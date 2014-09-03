class ApplicationFormDecorator < Draper::Decorator
  delegate_all
  
  def subject
    "#{character_name} - #{character_class}"
  end
  
  def body_text
    text = [character_info]
    structure.each do |(section, question_dict)|
      text << "<h3>#{section}</h3>"
      text << '<dl>'
      question_dict.each do |(question_id, question_label)|
        text << "<dt>#{question_label}</dt>"
        text << "<dd>#{self[question_id]}</dd>"
      end
      text << '</dl>'
    end
    text.join
  end
  
  def character_info
    text = []
    text << "<h3>Character Information</h3>"
    text << "<dl>"
    text << "<dt>Armory link</dt>"
    text << "<dd>#{armory_link}</dd>"
    text << "<dt>Main spec</dt>"
    text << "<dd>#{character_spec}</dd>"
    text << "</dl>"
    text.join
  end
  
  def armory_link
    h.link_to "#{source.character_name} @ #{source.server_name}", armory_url
  end
  
  def armory_url
    h.url_for("http://eu.battle.net/wow/en/character/#{source.server_name}/#{source.character_name}/advanced")
  end
end