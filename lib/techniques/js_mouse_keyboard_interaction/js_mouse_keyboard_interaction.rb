module JsMouseKeyboardInteraction
  
  # returns all necessary fields of the view
  def JsMouseKeyboardInteraction.get_additional_attributes
    [:js_mouse_keyboard_interaction]
  end
  
  # checks whether this technique is valid and returns an error message if necessary
  def JsMouseKeyboardInteraction.process_form(params)
    if (params[:js_mouse_keyboard_interaction] != "true") then
      "mouse/keyboard interaction: none detected!"
    end
  end
  
end