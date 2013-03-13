ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
#require 'rubyXL'
#require 'active_record'

require 'rubygems'
require 'pg'



#require 'yaml'

#load '~/.rvm/gems/ruby-1.9.2-p290/gems/nokogiri-1.5.0/lib/nokogiri.rb'
#load 'lib/nokogiri-1.5.0/lib/nokogiri.rb'
#load 'nokogiri'
require 'nokogiri'
require 'zip'
#load '~/.rvm/gems/ruby-1.9.2-p290/gems/rubyXL-1.2.7/lib/rubyXL.rb'
#load 'lib/rubyXL-1.2.7/lib/rubyXL.rb'


require 'rubyXL'


#ActiveRecord::Base.establish_connection(
  #:adapter  => 'sqlite3',
 #:database => 'development.sqlite3')

	#dbconfig = YAML::load(File.open('../config/database.yml'))
	#ActiveRecord::Base.establish_connection(dbconfig['development'])


#ActiveRecord::Base.establish_connection(:adapter => 'postgresql', :encoding => 'unicode', :database => 'sorteos', :pool=> 5, :username => 'sorteos', :password => 'tron9000', :host => 'localhost', :port => 5432 )

class Person < ActiveRecord::Base
  validates :num_empleado, :presence => true, :uniqueness => true
  validates :nombre, :presence => true
  validates :dependencia, :presence => true
end



workbook = RubyXL::Workbook.new
workbook = RubyXL::Parser.parse("/home/rolando/Descargas/Maestros(1).xlsx")

datos = workbook.worksheets[0].extract_data

x = 0
datos.each do |maestro|
	if x > 0
	#persona = Person.new
	nombre_completo = maestro[4].strip + " "unless maestro[4].nil? 
	nombre_completo.concat(maestro[2].strip + " ") unless maestro[2].nil?
	nombre_completo.concat(maestro[3].strip) unless maestro[3].nil?
	puts "Nombre: " + nombre_completo
	#persona.nombre = nombre_completo
	puts "Numero de empleado: " + maestro[1].to_s
	#persona.num_empleado = maestro[1].to_i
	puts "Dependencia" + maestro[0].strip
	#persona.dependencia = maestro[0].strip
	antiguedad = maestro[5].split(":") unless maestro[5].nil?	
	puts "Antiguedad: " + antiguedad[1] unless maestro[5].nil?
	#persona.antiguedad = antiguedad[1] unless maestro[5].nil? 	
	puts "\n\n"
	#persona.save


end
x = x + 1

end

