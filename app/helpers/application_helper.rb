module ApplicationHelper
  def main_content_class
    if content_for?(:left_sidebar) && content_for?(:right_sidebar)
      'span8'
    elsif content_for?(:left_sidebar)
      'span12 left-bordered'
    elsif content_for?(:right_sidebar)
      'span12 right-bordered'
    else
      'span16'
    end
  end
  
  def display_shoutbox_and_recruitment
    display_shoutbox
    display_recruitment
  end
  
  def display_shoutbox
    content_for(:left_sidebar, render('shoutbox'))
  end
  
  def display_recruitment
    content_for(:right_sidebar, render('recruitment')) 
  end
end
