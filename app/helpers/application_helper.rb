module ApplicationHelper
  def main_content_class
    if content_for?(:left_sidebar) && content_for?(:right_sidebar)
      'span6 left-bordered right-bordered'
    elsif content_for?(:left_sidebar)
      'span9 left-bordered'
    elsif content_for?(:right_sidebar)
      'span9 right-bordered'
    else
      'span12'
    end
  end
  
  def display_sidebars
    display_left_sidebar
    display_right_sidebar
  end
  
  def display_left_sidebar
    content_for(:left_sidebar, render('left_sidebar'))
  end
  
  def display_right_sidebar
    content_for(:right_sidebar, render('right_sidebar')) 
  end
  
  def latest_shoutbox_messages
    @latest_shoutbox_messages ||= ShoutboxMessage.ordered.page(params[:page]).decorate
  end
  
  def dismiss_modal_button(text = 'Close', &block)
    link_text = block_given? ? capture(&block) : text
    link_to link_text, '#', class: 'btn', data: { dismiss: 'modal' }
  end
  
end
