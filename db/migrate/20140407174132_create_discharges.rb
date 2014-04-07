class CreateDischarges < ActiveRecord::Migration
  def change
    create_table :discharges do |t|
      t.integer :ipdays
      t.boolean :active
      t.integer :phpvisits
      t.integer :dropreason_id
      t.string :otherdetail

      t.timestamps
    end
  end
end
