module <%= class_name %>
#the methods #get_additional_attributes, #prepare_form, #process_form are called up automatically 
#if you paste "<%= file_name %>: true" in the list of captcha_techniques of the config.yml file of transparent_captcha
#just fill out the blanks 
  
  def <%= class_name %>.get_additional_attributes
    #please name your attributes like "<%= file_name %>_attribute_name" in order to prevent name conflicts 
    #return an array containing the names of your attributes as symbols
    #e.g. [:<%= file_name %>_first_attribute, :<%= file_name %>_second_attribute]
  end

  def <%= class_name %>.prepare_form
    #this method is executed right before the form is rendered
  end

  def <%= class_name %>.process_form(params)
    #validate your captcha technique
    #this method is executed subsequent to the submission of the form
    #params[:name_of_your_attribute] returns the value of your attribute
    #return a error message as String if your captcha validation fails or nil elsewise
  end
  
end