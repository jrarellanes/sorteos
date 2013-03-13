ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
#require 'rubyXL'
#require 'active_record'

require 'rubygems'
require 'pg'

require 'nokogiri'
require 'zip'



require 'rubyXL'



class Person < ActiveRecord::Base
  validates :num_empleado, :presence => true, :uniqueness => true
  validates :nombre, :presence => true
  validates :dependencia, :presence => true
end



workbook = RubyXL::Workbook.new
workbook = RubyXL::Parser.parse("/home/rolando/Documentos/sorteo/db/bibliotecarios.xlsx")

datos = workbook.worksheets[0].extract_data

x = 0
datos.each do |bibliotecario|
	if x > 0
	persona = Person.new

	
	persona.nombre = bibliotecario[1]
	
	persona.num_empleado = bibliotecario[0].to_i
	
	persona.dependencia = bibliotecario[2]

	persona.activo = true
	
	persona.save


end
x = x + 1

end
