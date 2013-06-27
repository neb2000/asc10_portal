class TopicPostTimeSetter < Struct.new(:listener)
  def success(resource)
    resource.topic.touch :last_post_at
    listener.success resource
  end
  
  def failure(resource)
    listener.failure resource
  end
end