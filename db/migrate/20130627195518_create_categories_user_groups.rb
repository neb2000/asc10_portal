class CreateCategoriesUserGroups < ActiveRecord::Migration
  def change
    create_table :categories_user_groups, id: false do |t|
      t.integer :category_id
      t.integer :user_group_id
    end
    
    add_index :categories_user_groups, :category_id
    add_index :categories_user_groups, :user_group_id
  end
end