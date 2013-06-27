class CreateForumsBoards < ActiveRecord::Migration
  def change
    create_table :forums_boards do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :category_id
      t.integer :view_count, default: 0

      t.timestamps
    end
    add_index :forums_boards, :slug, unique: true
    add_index :forums_boards, :category_id
  end
end
