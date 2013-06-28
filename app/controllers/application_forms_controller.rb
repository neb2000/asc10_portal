class ApplicationFormsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_template_and_board
  respond_to :html
  
  before_filter { @current_nav_identifier = :apply }
  
  def new
    @application_form = ApplicationForms::Form.new_from_template @template
  end
  
  def create
    @application_form = ApplicationForms::Form.new_from_template(@template)
    @application_form.user = current_user
    @application_form.board = @board
    StandardUpdater.new(responder).update(@application_form, params[:application_form])
  end
  
  private
    def responder
      @responder ||= StandardResponder.new(self).tap { |responder| responder.redirect_path = root_path }
    end
    
    def find_template_and_board
      @template = SystemSetting.find_by_identifier('application_template').metadata
      @board    = Forums::Board.find SystemSetting.find_by_identifier('application_board').metadata
    end
end