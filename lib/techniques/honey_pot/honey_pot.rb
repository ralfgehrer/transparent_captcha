module HoneyPot
  
  # returns all necessary fields of the view
  def HoneyPot.get_additional_attributes
    [:honey_pot]
  end
  
  # checks whether this technique is valid and returns an error message if necessary
  def HoneyPot.process_form(params)
    unless params[:honey_pot].blank?
      "honey pot: the hidden field must not be filled out!"
    end  
  end
  
end

    