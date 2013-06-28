class Admin::SettingsController < Admin::ApplicationController
  def index
    authorize! :manage, :settings
    @banner_images = BannerImage.all.decorate
    @system_settings = SystemSetting.all
  end
end