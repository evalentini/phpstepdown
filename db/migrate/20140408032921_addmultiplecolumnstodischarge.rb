class Addmultiplecolumnstodischarge < ActiveRecord::Migration
  def change
    add_column :discharges, :medikid, :string
    add_column :discharges, :ishidden, :boolean, default: false
    add_column :discharges, :ipdischargedate, :date
    add_column :discharges, :phpdischargedate, :date
  end
end
