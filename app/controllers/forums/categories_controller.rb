module Forums
  class CategoriesController < ApplicationController
    before_filter :find_category
    authorize_resource
    respond_to :html
    
    def show
      @category = @category.decorate
      respond_with(@category)
    end
    
    private
      def find_category
        @category = Category.accessible_by(current_ability).includes(boards: [:views, {latest_post: [:topic, :user]}]).friendly.find(params[:id]) if params[:id]
      end
  end
end