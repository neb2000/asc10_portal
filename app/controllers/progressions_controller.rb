class ProgressionsController < ApplicationController
  respond_to :js, only: :ajax_get_progression
  
  def ajax_get_progression
    progression_yaml = Rails.cache.fetch('progressions', expires_in: SystemSetting.get_setting('progress_cache_expire').to_i) do
      puts 'loading from armory...'
      ProgressionReader.new(url: SystemSetting.get_setting('progress_reference_url'), raids: SystemSetting.get_setting('progress_raids')).report.to_yaml
    end
    @progression = YAML.load(progression_yaml)
    @npc_image_url = SystemSetting.get_setting('npc_image_url')
    
    respond_with(@progression)
  end
end