class Forums::ApplicationController < ApplicationController
  before_filter { @current_nav_identifier = :forums }
  
end