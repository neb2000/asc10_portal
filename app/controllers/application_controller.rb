class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_header  
  before_filter :set_current_online_users
  before_filter :ensure_proper_protocol
  
  helper_method :all_pages, :all_accessible_categories, :current_online_users, :current_online_user_ids
  
  rescue_from CanCan::AccessDenied do
    render template: 'errors/forbidden'#, status: 403
  end

  
  def all_pages
    @all_pages ||= Page.ordered.decorate
  end
  
  def all_accessible_categories
    @all_accessible_categories ||= Forums::Category.accessible_by(current_ability).includes(:boards).to_a
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
  
  
  def current_online_user_ids
    @current_online_user_ids ||= Rails.cache.fetch('online_users') do
      {}
    end.select{ |_, timestamp| timestamp > 5.minutes.ago }.keys
  end
  
  protected
    def ssl_configured?
      Rails.env.production?
    end
  
    def ssl_allowed_action?
      (params[:controller] == 'users/sessions' && ['new', 'create'].include?(params[:action])) ||
        (params[:controller] == 'users/registrations' && ['new', 'create', 'edit', 'update'].include?(params[:action])) ||
        (params[:controller] == 'users/omniauth_callbacks')
    end

    def ensure_proper_protocol
      if request.ssl? && !ssl_allowed_action?
        redirect_to "http://" + request.host + request.fullpath
      end
    end

    def after_sign_in_path_for(resource_or_scope)
      root_url(:protocol => 'http')
    end

    def after_sign_out_path_for(resource_or_scope)
      root_url(:protocol => 'http')
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
      User.where(id: online_users.select{ |_, timestamp| timestamp > 5.minutes.ago }.keys).order(:name).decorate
    end
end
