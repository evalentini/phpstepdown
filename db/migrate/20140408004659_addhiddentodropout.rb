class Addhiddentodropout < ActiveRecord::Migration
  def change
    add_column :dropreasons, :ishidden, :boolean, default: false
  end
end
