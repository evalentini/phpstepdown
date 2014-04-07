class CreateDropreasons < ActiveRecord::Migration
  def change
    create_table :dropreasons do |t|
      t.string :name

      t.timestamps
    end
  end
end
