class Admin::BannerImagesController < Admin::ApplicationController
  before_filter :find_banner_image
  respond_to :js, only: [:create, :destroy, :set_active]
  
  def new
    @banner_image = BannerImage.new
    respond_with(@banner_image) do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def create
    banner_image_params = params.require(:banner_image).permit!
    StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(BannerImage.new, banner_image_params)
  end
  
  def destroy
    StandardDestroyer.new(StandardAjaxResponder.new(self)).destroy(@banner_image)
  end
  
  def set_active
    BannerImage.update_all(["active = (id = ?)", @banner_image.id])
    @banner_image = @banner_image.reload.decorate
  end
  
  private
    def find_banner_image
      @banner_image = BannerImage.find(params[:id]) if params[:id]
    end
end