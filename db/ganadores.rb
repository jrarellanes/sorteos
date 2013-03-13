ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rubygems'
require 'simple_xlsx'

class Person < ActiveRecord::Base
  validates :num_empleado, :presence => true, :uniqueness => true
  validates :nombre, :presence => true
  validates :dependencia, :presence => true
end

lista_asistencia = Person.where("activo = ?", true)

serializer = SimpleXlsx::Serializer.new("lista_asistencia.xlsx") do |doc|
  doc.add_sheet("People") do |sheet|
    sheet.add_row(%w{Num Nombre Dependencia Antiguedad})
    lista_asistencia.each do |persona|
    	sheet.add_row([persona.num_empleado, 
                   persona.nombre, 
                   persona.dependencia, persona.antiguedad])
    end  
   end
end

ganadores = Person.where("activo = ? and premiado = ?", true, true)

serializer = SimpleXlsx::Serializer.new("ganadores.xlsx") do |doc|
  doc.add_sheet("People") do |sheet|
    sheet.add_row(%w{Num Nombre Dependencia Antiguedad})
    ganadores.each do |persona|
    	sheet.add_row([persona.num_empleado, 
                   persona.nombre, 
                   persona.dependencia, persona.antiguedad])
    end  
   end
end
