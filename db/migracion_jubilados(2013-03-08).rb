ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

require 'rubygems'
require 'pg'
require 'nokogiri'
require 'zip'
require 'rubyXL'


class Person < ActiveRecord::Base
  validates :num_empleado, :presence => true, :uniqueness => true
  validates :nombre, :presence => true
end



workbook = RubyXL::Workbook.new
workbook = RubyXL::Parser.parse("/home/rolando/Documentos/sorteo/db/listado_jubilados.xlsx")

datos = workbook.worksheets[0].extract_data

datos.each do |jubilado|
		persona = Person.create(:num_empleado => jubilado[0].to_i, :nombre => jubilado[1])
end

