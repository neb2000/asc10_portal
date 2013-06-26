class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.permission_identifiers.each do |permission|
      self.send permission if self.respond_to?(permission)
    end
  end
  
  def manage_news_entries
    can :manage, NewsEntry
  end
  
  def manage_pages
    can :manage, Page
  end
  
  def manage_recruitments
  end
  
  def manage_users
    can :manage, User
  end
  
  def manage_settings
  end
  
end
