module Timestamp
  
  # returns all necessary fields of the view
  def Timestamp.get_additional_attributes
    [:timestamp_time_view]
  end
  
  # checks whether this technique is valid and returns an error message if necessary
  def Timestamp.process_form(params)
    delay_in_seconds = YAML.load_file("#{RAILS_ROOT}/vendor/plugins/transparent_captcha/lib/techniques/timestamp/config.yml")['delay_in_seconds']
    now = Time.now.utc
    rendering_time = params[:timestamp_time_view].to_time(:local)
    rendering_time = rendering_time.utc
    
    if (now - rendering_time < delay_in_seconds) then
      "duration: invalid timestamp!"   
    end
  end
  
end