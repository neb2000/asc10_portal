# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

permissions = %w(manage_news_entries manage_pages manage_recruitments manage_messages manage_users manage_settings manage_forums_settings).map do |permission|
  Permission.where(identifier: permission).first_or_create(name: permission.humanize)
end