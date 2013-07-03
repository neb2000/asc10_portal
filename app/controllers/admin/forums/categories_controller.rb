module Admin
  module Forums
    class CategoriesController < Admin::ApplicationController
      respond_to :js, only: [:create, :update, :destroy]
      before_filter { @current_nav_identifier = :forums }
      before_filter :find_category
      authorize_resource class: ::Forums::Category

      def index
        @categories = ::Forums::Category.includes(:user_groups).decorate
        respond_with(@categories)
      end
      
      def new
        @category = ::Forums::Category.new
        respond_with(@category) do |format|
          format.html { render layout: !request.xhr? }
        end
      end
      
      def create
        StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(::Forums::Category.new, forums_category_params)
      end
      
      def edit
        respond_with(@category) do |format|
          format.html { render layout: !request.xhr? }
        end
      end
      
      def update
        StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(@category, forums_category_params)
      end
      
      def destroy
        StandardDestroyer.new(StandardAjaxResponder.new(self)).destroy(@category)
      end

      private
        def forums_category_params
          params.require(:forums_category).permit!
        end
        
        def find_category
          @category = ::Forums::Category.find(params[:id]) if params[:id]
        end
    end
  end
end