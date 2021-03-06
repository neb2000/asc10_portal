class StandardAjaxResponder < Struct.new(:controller)
  
  def success(resource)
    controller.current_resource = resource
    render_success(resource)
  end
  
  def failure(resource)
    controller.current_resource = resource
    render_failure(resource)
  end

  private    
    def render_success(resource)
      controller.respond_with(resource) do |format|
        format.js   { controller.render "#{controller.action_name}_success" }
      end
    end
    
    def render_failure(resource)
      controller.respond_with(resource) do |format|
        format.js   { controller.render "#{controller.action_name}_failure" }
      end
    end
end