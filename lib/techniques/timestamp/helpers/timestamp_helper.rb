module TimestampHelper
  
  # embed technique specific fields into view
  def embed_timestamp
    time_now = Time.now
    captcha_hidden_field_tag(:timestamp_time_view, time_now) # just for handover from action to action
  end
  
end