require "yaml"
# include view helper
require 'app/helpers/transparent_captcha_helper.rb'
ActionView::Base.class_eval { include TransparentCaptchaHelper}

##########################################################################################################################

# load configurations
$encryption = YAML.load_file("#{RAILS_ROOT}/vendor/plugins/transparent_captcha/config.yml")['encryption']
$garbage_collector = YAML.load_file("#{RAILS_ROOT}/vendor/plugins/transparent_captcha/config.yml")['garbage_collector']

##########################################################################################################################

# load techniques
all_techniques = YAML.load_file("#{RAILS_ROOT}/vendor/plugins/transparent_captcha/config.yml")['captcha_techniques']

# select desired techniques
desired_techniques = all_techniques.keys.inject([]) do |array, technique|
  file_path_of_technique = File.expand_path(File.dirname(__FILE__) + '/lib/techniques/' + technique + '/' + technique + '.rb')
  array << technique if all_techniques[technique] && File.exist?(file_path_of_technique)
  array 
end

# embed techniques into TransparentCaptcha
TransparentCaptcha.class_eval do
  desired_techniques.each do |technique|
    require File.expand_path(File.dirname(__FILE__) + '/lib/techniques/' + technique + '/' + technique)
  end
end

# require and include helpers of all techniques
desired_techniques.each do |technique|
  require File.expand_path(File.dirname(__FILE__) + '/lib/techniques/' + technique + '/helpers/' + technique +'_helper.rb')
end
desired_techniques.each do |technique|
  ActionView::Base.class_eval { include ((technique.camelize + 'Helper').constantize) }
end

# create list of current technique
$captcha_techniques = desired_techniques.inject([]){ |array, technique| array << technique.camelize.constantize; array }

##########################################################################################################################

