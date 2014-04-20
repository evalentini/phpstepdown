class AddGenderToDischarges < ActiveRecord::Migration
  def change
    add_column :discharges, :gender, :string, default: "M"
  end
end
