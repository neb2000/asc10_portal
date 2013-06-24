class CreateNewsEntries < ActiveRecord::Migration
  def change
    create_table :news_entries do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
