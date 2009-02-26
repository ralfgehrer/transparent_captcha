module JsMouseKeyboardInteractionHelper
  
  # embed technique specific fields and javascrips into view
  def embed_js_mouse_keyboard_interaction
    [
    javascript_include_tag("js_mouse_keyboard_interaction"),
    captcha_hidden_field_tag(:js_mouse_keyboard_interaction)
    ].join
  end
  
  # add js events to CAPTCHA form
  def get_js_options_of_js_mouse_keyboard_interaction
    options = {}
    options[:onmousedown] = "interactionEvent('#{@captcha.encrypted_attributes[:js_mouse_keyboard_interaction]}')" 
    options[:onkeydown] = "interactionEvent('#{@captcha.encrypted_attributes[:js_mouse_keyboard_interaction]}')"
    options
  end
  
end