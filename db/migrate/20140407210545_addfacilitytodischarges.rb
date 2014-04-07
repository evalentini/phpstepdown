class Addfacilitytodischarges < ActiveRecord::Migration
  def change
    add_column :discharges, :facility_id, :integer
  end
end
