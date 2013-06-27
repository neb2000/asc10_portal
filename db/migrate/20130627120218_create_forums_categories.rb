class CreateForumsCategories < ActiveRecord::Migration
  def change
    create_table :forums_categories do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.boolean :public, default: false

      t.timestamps
    end
    add_index :forums_categories, :slug, unique: true
  end
end
