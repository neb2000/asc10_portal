class AddCoverImageToNewsEntries < ActiveRecord::Migration
  def change
    add_column :news_entries, :cover_image, :string
  end
end
