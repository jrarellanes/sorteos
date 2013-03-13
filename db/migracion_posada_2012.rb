#encoding: utf-8
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
workbook = RubyXL::Parser.parse("/home/rolando/Documentos/sorteo/db/listado_final_posada_2012.xlsx")

datos = workbook.worksheets[0].extract_data

x = 0
datos.each do |bibliotecario|
	if x > 0
	persona = Person.new

	
	persona.nombre = bibliotecario[1]
	
	persona.num_empleado = bibliotecario[0].to_i
	
	persona.dependencia = bibliotecario[3]
	
	if persona.num_empleado == 15481 or persona.num_empleado == 17319 or persona.num_empleado == 
17738 or persona.num_empleado == 8401 or persona.num_empleado == 17359 or persona.num_empleado == 17922 or persona.num_empleado == 18974 or persona.num_empleado == 91155 or persona.num_empleado == 9876 or persona.num_empleado == 15483 or persona.num_empleado == 10363 or persona.num_empleado == 15509 or persona.num_empleado == 5465 or persona.num_empleado == 12068 or persona.num_empleado == 10288 or persona.num_empleado == 18648 or persona.num_empleado == 9287 or persona.num_empleado == 8502 or persona.num_empleado == 17853
		persona.activo = true
	else
		persona.activo = false
	end
	
	unless persona.save
    	p_g = Person.find_by_num_empleado persona.num_empleado
    	puts "Persona ya guardada: #{p_g.nombre}  Num_empleado: #{p_g.num_empleado}"
    	puts "Persona que no se guardó: #{persona.nombre} Num_empleado: #{persona.num_empleado}\n "
	end



end
x = x + 1

end
