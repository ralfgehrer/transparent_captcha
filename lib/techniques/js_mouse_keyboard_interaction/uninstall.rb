require 'fileutils'
# removes js file from public/javascripts folder
FileUtils.rm File.join(File.dirname(__FILE__), '../../../../../../public/javascripts/js_mouse_keyboard_interaction.js')