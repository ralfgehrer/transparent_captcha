require 'fileutils'

# call the install files of the available techniques
Dir.glob("vendor/plugins/transparent_captcha/lib/techniques/*/install.rb").each do |install_file|
  require install_file
end

