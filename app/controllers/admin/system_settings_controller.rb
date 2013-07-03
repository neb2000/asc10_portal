class Admin::SystemSettingsController < Admin::ApplicationController
  before_filter :find_system_setting  
  authorize_resource
  
  respond_to :js, only: [:update]
  
  def edit
    respond_with(@system_setting) do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def update
    StandardUpdater.new(StandardAjaxResponder.new(self)).update(@system_setting, params.require(:system_setting).permit!)
  end
    
  private
    def find_system_setting
      @system_setting = SystemSetting.find(params[:id]) if params[:id]
    end
end