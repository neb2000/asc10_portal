class RegistrationsController < Devise::RegistrationsController
  force_ssl only: [:new, :create, :edit, :update], if: :ssl_configured?
  before_filter :configure_permitted_parameters
  
  protected
    def after_inactive_sign_up_path_for(resource)
      root_url(:protocol => 'http')
    end

    def after_sign_up_path_for(resource)
      root_url(:protocol => 'http')
    end

    def after_update_path_for(resource)
      edit_user_registration_url(:protocol => 'http')
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    end
end