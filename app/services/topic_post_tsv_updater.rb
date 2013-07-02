class TopicPostTsvUpdater < Struct.new(:listener)
  def success(resource, klass = Forums::Post)
    klass.where(topic_id: resource.id).update_all('id = id')
    listener.success resource
  end
  
  def failure(resource)
    listener.failure resource
  end
end