require 'fileutils'

# call the uninstall files of the available techniques
Dir.glob("vendor/plugins/transparent_captcha/lib/techniques/*/uninstall.rb").each do |uninstall_file|
  require uninstall_file
end 