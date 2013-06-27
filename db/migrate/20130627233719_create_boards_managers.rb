class CreateBoardsManagers < ActiveRecord::Migration
  def change
    create_table :boards_managers, id: false do |t|
      t.integer :board_id
      t.integer :manager_id
    end
    
    add_index :boards_managers, :board_id
    add_index :boards_managers, :manager_id
  end
end