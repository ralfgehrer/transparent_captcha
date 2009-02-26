module HoneyPotHelper
 
  # embed technique specific fields into view
  def embed_honey_pot
    "<div style='position: absolute; left: -2000px;'>" + captcha_text_field_tag(:honey_pot) + "</div>"
  end
  
end