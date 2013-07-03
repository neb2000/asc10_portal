class SystemSetting < ActiveRecord::Base
  serialize :metadata
  
  def self.get_setting(identifier)
    find_by_identifier(identifier).try(:metadata)
  end
  
  def metadata_json
    metadata.is_a?(String) ? metadata : metadata.to_json
  end
  
  def metadata_json=(json_string)
    self.metadata = (JSON.parse(json_string) rescue json_string)
  end
end
