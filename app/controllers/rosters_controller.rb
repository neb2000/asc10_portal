class RostersController < ApplicationController
  respond_to :js, only: :ajax_get_roster
  before_filter { @current_nav_identifier = :roster }
  
  def show
  end
  
  def ajax_get_roster
    roster_yaml = Rails.cache.fetch('roster', expires_in: SystemSetting.get_setting('roster_cache_expire').to_i) do
      puts 'loading from armory...'
      RosterReader.new(url: SystemSetting.get_setting('roster_api_url'), ranks: SystemSetting.get_setting('roster_raider_ranks')).filtered_members.to_yaml
    end
    @roster = YAML.load(roster_yaml)
    @armory_link = SystemSetting.get_setting('roster_armory_link')
    respond_with(@roster)
  end  
end