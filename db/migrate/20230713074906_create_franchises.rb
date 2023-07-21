class CreateFranchises < ActiveRecord::Migration[7.0]
  def change
    create_table :franchises do |t|
      t.string :name
      t.text :description
      t.text :address
      t.string :location
      
      t.timestamps
    end
  end
end
