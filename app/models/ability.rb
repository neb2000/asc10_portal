class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.permission_identifiers.each do |permission|
      self.send permission if self.respond_to?(permission)
    end
    
    message_permissions
    forum_permissions
  end
  
  def message_permissions
    can [:read, :mark_read_unread], ActsAsMessageable::Message, received_messageable_id: @user.id, received_messageable_type: 'User'
    can :manage, ActsAsMessageable::Message, sent_messageable_id: @user.id, sent_messageable_type: 'User'
  end
  
  def forum_permissions
    can :read, Forums::Category, id: @user.readable_category_ids
    can [:read, :create_topic], Forums::Board, category: { id: @user.readable_category_ids }
    can [:read, :reply], Forums::Topic, board: { category: { id: @user.readable_category_ids } }
    can [:read, :reply], Forums::Post,  topic: { board: { category: {id: @user.readable_category_ids } } }
    
    can :read, Forums::Category, public: true
    can [:read, :create_topic], Forums::Board, category: { public: true }
    can [:read, :reply], Forums::Topic, board: { category: { public: true } }
    can [:read, :reply], Forums::Post,  topic: { board: { category: { public: true } } }
    
    can :manage, Forums::Topic, board: { id: @user.managed_board_id_list }
    can :manage, Forums::Post,  topic: { board: { id: @user.managed_board_id_list } }
    
    can [:update, :destroy], [Forums::Post, Forums::Topic], user_id: @user.id
    cannot [:update, :destroy, :reply], Forums::Topic, locked: true
    cannot [:update, :destroy, :reply], Forums::Post, topic: { locked: true }
  end
  
  def manage_forums_settings
    can :manage, :forums
    can :manage, Forums::Board
    can :manage, Forums::Category
    can :manage, Forums::Topic
    can :manage, Forums::Post
  end
  
  def manage_news_entries
    can :manage, NewsEntry
  end
  
  def manage_pages
    can :manage, Page
  end
  
  def manage_recruitments
    can :manage, Recruitment
  end
  
  def manage_users
    can :manage, User
    # cannot :edit, User, id: @user.id
  end
  
  def manage_messages
    can :manage, ShoutboxMessage
  end
  
  def manage_settings
    can :manage, :settings
    can :manage, BannerImage
  end
  
end
