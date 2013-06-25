module ApplicationHelper
  def main_content_class
    if content_for?(:left_sidebar) && content_for?(:right_sidebar)
      'span6'
    elsif content_for?(:left_sidebar)
      'span9 left-bordered'
    elsif content_for?(:right_sidebar)
      'span9 right-bordered'
    else
      'span12'
    end
  end
  
  def display_shoutbox_and_recruitment
    content_for(:left_sidebar, render('shoutbox')) 
    content_for(:right_sidebar, render('recruitment')) 
  end
end
