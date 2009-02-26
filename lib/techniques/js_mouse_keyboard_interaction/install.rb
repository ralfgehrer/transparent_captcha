require 'fileutils'
# copies js file into public/javascripts folder 
FileUtils.cp File.join(File.dirname(__FILE__), 'javascripts/js_mouse_keyboard_interaction.js'), File.join(File.dirname(__FILE__), '../../../../../../public/javascripts')