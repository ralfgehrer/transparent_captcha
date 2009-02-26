class CaptchaTechniqueGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      
      # Directory
      dir = "vendor/plugins/transparent_captcha/lib/techniques/#{file_name}"
      m.directory dir
      m.directory dir + "/helpers"
      m.directory dir + "/javascripts"

      # Helper
      m.template "helpers/technique_helper.rb", (dir + "/helpers/#{file_name}_helper.rb")

      # Javascript
      m.file "javascripts/technique.js", (dir + "/javascripts/#{file_name}.js")
      
      # Module
      m.template "technique.rb", (dir + "/#{file_name}.rb")

      # Install
      m.template "install.rb", (dir + "/install.rb")
      m.template "uninstall.rb", (dir + "/uninstall.rb")
      
      
      #m.migration_template "migrate/create_users.rb", "db/migrate"
    end
  end

end
