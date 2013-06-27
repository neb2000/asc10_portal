class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.permission_identifiers.each do |permission|
      self.send permission if self.respond_to?(permission)
    end
    
    can :read, ActsAsMessageable::Message, received_messageable_id: @user.id, received_messageable_type: 'User'
    can :manage, ActsAsMessageable::Message, sent_messageable_id: @user.id, sent_messageable_type: 'User'
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
    cannot :edit, User, id: @user.id
  end
  
  def manage_messages
    can :manage, ShoutboxMessage
  end
  
  def manage_settings
    can :manage, :settings
    can :manage, BannerImage
  end
  
end
