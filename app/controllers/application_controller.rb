class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_header  
  before_filter :set_current_online_users
  helper_method :all_pages, :current_online_users
  
  def all_pages
    @all_pages ||= Page.ordered.decorate
  end
  
  ## The following are used by our Responder service classes so we can access
  ## the instance variable for the current resource easily via a standard method  
  def resource_name
    controller_name.demodulize.singularize
  end
  
  def current_resource
    instance_variable_get(:"@#{resource_name}")
  end
  
  def current_resource=(val)
    instance_variable_set(:"@#{resource_name}", val)
  end
  
  def current_online_users
    @current_online_users ||= get_current_online_users
  end
  
  
  private
    def set_header
      response.headers['X-XSS-Protection'] = "0"
    end
    
    def set_current_online_users
      return unless user_signed_in?
      online_users = Rails.cache.fetch('online_users') do
        {}
      end
      online_users[current_user.id] = Time.now.utc
      Rails.cache.write('online_users', online_users)
    end    
    
    def get_current_online_users
      online_users = Rails.cache.fetch('online_users') do
        {}
      end
      User.where(id: online_users.select{ |_, timestamp| timestamp > 5.minutes.ago }.keys).decorate
    end
end
