class ApplicationController < ActionController::Base
  protect_from_forgery
  
  ## The following are used by our Responder service classes so we can access
  ## the instance variable for the current resource easily via a standard method
  def resource_name
    controller_name.demodulize.singularize
  end
  
  def current_resource
    instance_variable_get(:"@#{resource_name}")
  end
  
  def current_resource=(val)
    instance_variable_set(:"@#{resource_name}", val)
  end
end
