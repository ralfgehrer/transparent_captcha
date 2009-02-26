module <%= class_name %>Helper
#the methods #embed_<%= file_name %> and #get_js_options_of_<%= file_name %> are called up automatically
#just fill out the blanks 
  
  def embed_<%= file_name %>
    #please return all html-tags like input fields, javascripts, etc. as string to include them into the view 
  end
 
  def get_js_options_of_<%= file_name %>
    # to execute javascript on form events you can include them here
    # please return a hash with the events as key and the JS method call as value
    # e.g {:onload => "executed_method(params)"
  end
  
end