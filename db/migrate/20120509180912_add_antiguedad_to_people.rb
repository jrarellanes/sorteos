class AddAntiguedadToPeople < ActiveRecord::Migration
  def change
    add_column :people, :antiguedad, :integer
  end
end
