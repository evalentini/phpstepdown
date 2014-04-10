class Addphpstartdate < ActiveRecord::Migration
  def change
    add_column :discharges, :phpstartdate, :date
  end
end
