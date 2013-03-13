ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")


require 'rubygems'
require 'pg'




require 'nokogiri'
require 'zip'


require 'rubyXL'


class Person < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :dependencia, :presence => true
end



workbook = RubyXL::Workbook.new
workbook = RubyXL::Parser.parse("/home/rolando/Documentos/sorteo/db/participantest3.xlsx")

datos = workbook.worksheets[0].extract_data

x = 0
datos.each do |maestro|
	if x > 0
	persona = Person.new
	nombre_completo = maestro[0].strip + " "unless maestro[0].nil? 
	nombre_completo.concat(maestro[1].strip + " ") unless maestro[1].nil?
	nombre_completo.concat(maestro[2].strip) unless maestro[2].nil?
	#puts "Nombre: " + nombre_completo
	persona.nombre = nombre_completo
	persona.dependencia = maestro[4].strip
	#puts "\n\n"
	persona.save

end
x = x + 1

end
