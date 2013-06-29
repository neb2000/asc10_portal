# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w(manage_news_entries manage_pages manage_recruitments manage_messages manage_users manage_settings manage_forums_settings).each do |permission|
  Permission.where(identifier: permission).first_or_create(name: permission.humanize)
end

%w(officer raider trial).each do |user_group|
  UserGroup.where(identifier: user_group).first_or_create(name: user_group.humanize)
end

%w(deathknight druid hunter mage monk paladin priest rogue shaman warlock warrior).each do |class_name|
  Recruitment.where(identifier: class_name).first_or_create(name: class_name.humanize)
end

%w(application_template application_board roster_api_url roster_raider_ranks roster_armory_link roster_cache_expire).each do |identifier|
  SystemSetting.where(identifier: identifier).first_or_create(description: identifier.humanize)
end