class StandardUpdater < Struct.new(:listener)
  def update(record, params, as = :default)
    record.assign_attributes params, as: as
    if record.save
      listener.success(record)
    else
      listener.failure(record)
    end
  end
end