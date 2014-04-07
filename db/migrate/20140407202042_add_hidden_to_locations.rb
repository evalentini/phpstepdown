class AddHiddenToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :ishidden, :boolean, default: false
  end
end
