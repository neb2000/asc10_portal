class AddDisplayFlagsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :display_shoutbox, :boolean, default: true
    add_column :pages, :display_recruitment, :boolean, default: true
  end
end
