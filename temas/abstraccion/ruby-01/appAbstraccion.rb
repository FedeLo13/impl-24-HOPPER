require 'sinatra'
require_relative 'abstraccion.rb'

get '/' do
    erb :index
end

get '/Circulo/:radio' do
    radio = params[:radio].to_f
    circulo = Figura::Circulo.new(radio)
    output = StringIO.new
    $stdout = output
    puts "Círculo: "
    puts "Área: #{circulo.area.to_s}"
    puts "Perímetro: #{circulo.perimetro.to_s}"
    $stdout = STDOUT
    output.string
end

get '/Rectangulo/:ancho/:alto' do
    ancho = params[:ancho].to_f
    alto = params[:alto].to_f
    rectangulo = Figura::Rectangulo.new(ancho, alto)
    output = StringIO.new
    $stdout = output
    puts "Rectángulo: "
    puts "Área: #{rectangulo.area.to_s}"
    puts "Perímetro: #{rectangulo.perimetro.to_s}"
    $stdout = STDOUT
    output.string
end

get '/Triangulo/:base/:altura/:lado1/:lado2/:lado3' do
    base = params[:base].to_f
    altura = params[:altura].to_f
    lado1 = params[:lado1].to_f
    lado2 = params[:lado2].to_f
    lado3 = params[:lado3].to_f
    triangulo = Figura::Triangulo.new(base, altura, lado1, lado2, lado3)
    output = StringIO.new
    $stdout = output
    puts "Triángulo: "
    puts "Área: #{triangulo.area.to_s}"
    puts "Perímetro: #{triangulo.perimetro.to_s}"
    $stdout = STDOUT
    output.string
end

set :port, 4568