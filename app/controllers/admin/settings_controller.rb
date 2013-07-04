class Admin::SettingsController < Admin::ApplicationController
  before_filter { @current_nav_identifier = :settings }
  def index
    authorize! :manage, :settings
    @banner_images = BannerImage.all.decorate
    @system_settings = SystemSetting.all
  end
end