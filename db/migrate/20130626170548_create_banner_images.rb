class CreateBannerImages < ActiveRecord::Migration
  def change
    create_table :banner_images do |t|
      t.string :file
      t.boolean :active

      t.timestamps
    end
  end
end
