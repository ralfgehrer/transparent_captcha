module JsCalculationHelper
  
  # embed technique specific fields and javascrips into view
  def embed_js_calculation
    [
      javascript_include_tag("js_calculation"),
      captcha_hidden_field_tag(:js_calculation_result),
      captcha_hidden_field_tag(:js_calculation_x, @js_calculation_x), # just for handover from action to action
      captcha_hidden_field_tag(:js_calculation_y, @js_calculation_y) # just for handover from action to action,
     ].join
  end
 
  # add js events to CAPTCHA form
  def get_js_options_of_js_calculation
    options = {}
    @js_calculation_x = rand(1000)
    @js_calculation_y = rand(1000)
    
    options[:onsubmit] = "calc(" + @js_calculation_x.to_s + "," + @js_calculation_y.to_s  + ",'" +@captcha.encrypted_attributes[:js_calculation_result].to_s + "')"
    
    options
  end
  
end