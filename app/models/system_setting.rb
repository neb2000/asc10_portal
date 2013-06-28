class SystemSetting < ActiveRecord::Base
  attr_accessible :identifier, :description, :metadata
  
  serialize :metadata
  
  def metadata_json
    metadata.to_json
  end
  
  def metadata_json=(json_string)
    self.metadata = JSON.parse(json_string)
  end
end
