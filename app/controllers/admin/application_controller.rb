class Admin::ApplicationController < ::ApplicationController
  before_filter :authenticate_user!
  
  layout 'admin'
  
  respond_to :html
end