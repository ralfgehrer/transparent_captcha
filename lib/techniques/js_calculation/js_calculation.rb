module JsCalculation
  
  # returns all necessary fields of the view
  def JsCalculation.get_additional_attributes
    [:js_calculation_x, :js_calculation_y, :js_calculation_result]
  end
  
  # checks whether this technique is valid and returns an error message if necessary
  def JsCalculation.process_form(params) 
    js_calculation_x = params[:js_calculation_x].to_i
    js_calculation_y = params[:js_calculation_y].to_i
    js_calculation_result = params[:js_calculation_result].to_i

    if (js_calculation_x + js_calculation_y != js_calculation_result) then
      "js calculation: result is not correct!"
    end  
  end
  
end