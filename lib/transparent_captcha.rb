class TransparentCaptcha
  require 'digest/md5'
  require File.join(File.dirname(__FILE__), 'app/models/captcha_secret')
   
  attr_reader :secret
  attr_reader :list_of_attributes
  attr_reader :list_of_additional_attributes
  attr_reader :encrypted_attributes
  attr_reader :values
  attr_reader :additional_values
  attr_reader :errors

  # initialize instance variables and create list of ALL attributes for the view
  def initialize(list_of_attributes)
    @list_of_attributes = list_of_attributes
    @list_of_additional_attributes = get_additional_attributes()
    @errors = []
  end
  
  # encrypt all field names of the form an call prepare action of all available techniques
  # before the rendering of the view
  def prepare_form
    @secret = CaptchaSecret.create!(:timestamp => DateTime.now)
    @encrypted_attributes = encrypt_attributes(@list_of_attributes|@list_of_additional_attributes)
    
    $captcha_techniques.each { |technique| technique.prepare_form if technique.respond_to?("prepare_form") }
  end
  
  # decrypt all field names of the submitted http_params of the form, call each technique to evaluate their
  # CAPTCHA and store the error messages in @errors
  def process_form(http_params)
    @secret = CaptchaSecret.find(http_params[:id_captcha_secret])
    enable_processing(http_params)

    $captcha_techniques.each { |technique| @errors << technique.process_form(@additional_values)}
    @secret.destroy
    #destroy all obsolete records of CaptchaSecret if and only if :triggered_on_submit is true
    CaptchaSecret.destroy_obsolete_records if $garbage_collector[:triggered_on_submit]
    @errors.compact!
  end
  
  # if the CAPTCHA is valid it will return true else false
  def valid?
    @errors.empty?
  end
  
  # returns an already HTML formated error message containing explanations why each technique failed
  def get_error_message()
    error_message = "Detected spam based on: <br /><ul>"
    @errors.each {|error| error_message += "<li>"+ error.to_s + "</li>"}
    error_message += "</ul>"
    error_message
  end
  
  private
  
  # asks the different techniques for their additional attributes
  def get_additional_attributes 
    additional_attributes = Set.new
    $captcha_techniques.each do |technique|
      additional_technique_attributes = technique.get_additional_attributes
      if (additional_technique_attributes != nil) then
        additional_technique_attributes.each do |attribute|
        if (additional_attributes.add?(attribute) == nil) then
          raise "Name conflict: " + technique.to_s + " uses the already assigned attribute name '" + attribute.to_s + "'!"
        end
      end  
      end
      
    end
    additional_attributes.to_a
  end
  
  # decrypts oerhanded attributes
  def enable_processing(http_params)
    #encrypts all attributes with spinner revealed from form
    all_attributes = @list_of_attributes|@list_of_additional_attributes
    @encrypted_attributes = encrypt_attributes(all_attributes)
    
    #retrieves the values of the attributes
    @values = retrieve_values(@list_of_attributes, http_params)
    @additional_values = retrieve_values(@list_of_additional_attributes, http_params)
  end  
  
  #encrypts attributes based on chosen spinner  
  #creates a hash containing the pairs: original_attribute_name => encrypted_attribute_name
  def encrypt_attributes(list_of_attributes)
    list_of_attributes.inject({}){|hash, attribute| hash[attribute] = encrypt_attribute(attribute); hash }
  end
  
  #encrypts a single attribute
  def encrypt_attribute(attribute)
    if $encryption[:enabled] then
      Digest::MD5.hexdigest(attribute.to_s + $encryption[:key] + @secret.timestamp.to_s)
    else
      attribute.to_s
    end    
  end
  
  #creates a hash, containing the pairs: original attribute => assigned value
  def retrieve_values(original_attributes, http_params)
    original_attributes.inject({}){|hash, attribute| hash[attribute] = http_params[@encrypted_attributes[attribute]]; hash }
  end

end