class CaptchaSecret < ActiveRecord::Base
  
  # action to destroy all CaptchaSecrets which are older than the specified duration in the config.yml
  def self.destroy_obsolete_records() 
    date = (DateTime.now.utc - $garbage_collector[:maximum_age_of_record][:number_of_days].to_i.days - $garbage_collector[:maximum_age_of_record][:number_of_hours].to_i.hours - $garbage_collector[:maximum_age_of_record][:number_of_minutes].to_i.minutes)
    self.destroy_all("created_at < '" + date.to_s  + "'")
  end
  
end