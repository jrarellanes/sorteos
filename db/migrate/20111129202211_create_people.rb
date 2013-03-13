class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :num_empleado
      t.string :nombre
      t.string :dependencia
      t.boolean :activo, :default => false
      t.boolean :premiado, :default => false
      t.timestamps
    end
  end
end
