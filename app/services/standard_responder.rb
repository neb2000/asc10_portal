class StandardResponder < Struct.new(:controller)
  attr_writer :redirect_path
  
  def success(resource)
    controller.current_resource = resource
    set_success_message
    success_response(resource)
  end
  
  def failure(resource)
    controller.current_resource = resource
    set_failure_message
    failure_response(resource)
  end

  private
    def success_message
      "Successfully saved record."
    end
  
    def failure_message
      "Failed to save record, please check the form for errors."
    end
    
    def success_response(resource)
      controller.respond_with(resource, location: redirect_path)
    end
    
    def failure_response(resource)
      controller.respond_with(resource, location: redirect_path)
    end
  
    def redirect_path
      @redirect_path || controller.url_for(action: :index)
    end
  
    def set_success_message
      controller.flash[:notice] = success_message
    end
  
    def set_failure_message
      controller.flash.now[:alert] = failure_message
    end
end