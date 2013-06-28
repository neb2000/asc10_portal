class SystemSetting < ActiveRecord::Base
  attr_accessible :identifier, :description, :metadata, :metadata_json
  
  serialize :metadata
  
  def metadata_json
    metadata.is_a?(String) ? metadata : metadata.to_json
  end
  
  def metadata_json=(json_string)
    self.metadata = (JSON.parse(json_string) rescue json_string)
  end
end
