module FormHelper
  
  def cancel_button(url, text="Cancel")
    link_to url, title: text, class: 'btn' do
      "#{content_tag(:i, '', class: 'icon-remove')} #{text}".html_safe
    end
  end
  
  def submit_button(text="Save", opts = {}) 
    content_tag :button, opts.merge(type: :submit, class: 'btn btn-primary') do
      "#{content_tag(:i, '', class: 'icon-ok')} #{text}".html_safe
    end
  end
  
  def search_button(text="Search") 
    content_tag :button, type: :submit, class: 'btn btn-primary btn-small' do
      "#{content_tag(:i, '', class: 'icon-search')} #{text}".html_safe
    end
  end
  
  def reset_button  
    content_tag :button, type: :reset, class: 'btn' do
      "#{content_tag(:i, '', class: 'icon-undo')} Reset".html_safe
    end
  end
  
end