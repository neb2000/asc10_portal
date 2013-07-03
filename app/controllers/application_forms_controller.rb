class ApplicationFormsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_template_and_board
  respond_to :html
  
  before_filter { @current_nav_identifier = :apply }
  
  def new
    authorize! :create, :application_form
    @application_form = ApplicationForms::Form.new_from_template @template
  end
  
  def create
    authorize! :create, :application_form
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
      @template = SystemSetting.get_setting('application_template')
      @board    = Forums::Board.find SystemSetting.get_setting('application_board')
    end
end