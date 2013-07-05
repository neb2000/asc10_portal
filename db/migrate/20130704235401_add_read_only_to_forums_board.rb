class AddReadOnlyToForumsBoard < ActiveRecord::Migration
  def change
    add_column :forums_boards, :read_only, :boolean, default: false
  end
end
