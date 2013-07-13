class PostsResponder < StandardResponder
  def success_response(resource)
    controller.respond_with(resource, location: resource.link_to_topic)
  end
end