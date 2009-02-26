module TransparentCaptchaHelper
  
  # Helper to create a form containing encrypted fields based on a model 
  def captcha_form_for(model, &block)
    @include_put_method = false
    link_name = model.class.name.pluralize.underscore
    if (model.id == nil) then
      captcha_form_tag "/" + link_name + "/create"
    else
      @include_put_method = true
      url_for_options = "/" + link_name + "/" + model.id.to_s
      captcha_form_tag (url_for_options, {}, &block)
    end
  end
  
  # Helper to create an ordinary form containing encrypted fields
  def captcha_form_tag(url_for_options = {}, options = {}, *parameters_for_url, &block)
    $captcha_techniques.each do |technique|
      method_name = "get_js_options_of_" + technique.to_s.underscore
      if respond_to?(method_name) then
        options_technique =  send(method_name)  
        
        # merge options
        if (options_technique != nil) then
          options_technique.each_pair do |key,value|
            unless options[key] == nil then
              options[key] = options[key] + value + ";"
            else
              options[key] = value + ";"
            end
          end    
        end        
      end
    end   
    
    form_tag (url_for_options, options, &block)
  end

  # Helper to create a text field with an encrypted name
  def captcha_text_field_tag(field_name, field_value = nil, options={})
    text_field_tag(@captcha.encrypted_attributes[field_name], field_value, options)
  end
  
  # Helper to create a text field with an encrypted name but original label
  def captcha_label_for(field_name, label)
    "<label_for=\"" + @captcha.encrypted_attributes[field_name] + "\">" + label + "</label>"
  end
  
  # Helper to create a hidden field with an encrypted name
  def captcha_hidden_field_tag(field_name, field_value = nil)
    hidden_field_tag(@captcha.encrypted_attributes[field_name], field_value)
  end
  
  # Helper to include all HTML tags which are necessary for the techniques
  def embed_additional_tags
    # embed secret ID
    tags = hidden_field_tag(:id_captcha_secret, @captcha.secret.id)
    
    # embed put method
     tags +=   "<input name=\"_method\" type=\"hidden\" value=\"put\" />" if (@include_put_method)

    #embed all techniques
    $captcha_techniques.each do |technique|
      method_name = "embed_" + technique.to_s.underscore
      technique_tags = send(method_name) if respond_to?(method_name)
      tags += technique_tags if (technique_tags != nil)
    end       
    
    tags
  end
  
end