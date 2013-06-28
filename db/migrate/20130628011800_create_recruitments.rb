class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.string :identifier
      t.string :name
      t.string :spec
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
