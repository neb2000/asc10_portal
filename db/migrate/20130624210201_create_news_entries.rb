class CreateNewsEntries < ActiveRecord::Migration
  def change
    create_table :news_entries do |t|
      t.string :title
      t.string :slug
      t.text :content

      t.timestamps
    end
    
    add_index :news_entries, :slug, unique: true
  end
end