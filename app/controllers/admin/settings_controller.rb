class Admin::SettingsController < Admin::ApplicationController
  def index
    authorize! :manage, :settings
    @banner_images = BannerImage.scoped.decorate
    @system_settings = SystemSetting.scoped
  end
end