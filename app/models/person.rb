class Person < ActiveRecord::Base
  validates :num_empleado, :presence => true, :uniqueness => true
  validates :nombre, :presence => true
  validates :dependencia, :presence => true
end
