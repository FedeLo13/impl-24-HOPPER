require 'sinatra'
require_relative 'Orquesta'

$orquesta = Orquesta.new

get '/' do
  erb :index, locals: { orquesta: $orquesta }
end

get '/agregar/Viento/:nombre' do
  n = params[:nombre]
  flauta = Viento.new(n)
  $orquesta.add_instrumento(flauta)
  "Agregando Viento"
end

get '/agregar/Cuerda/:nombre' do
  n = params[:nombre]
  guitarra = Cuerda.new(n)
  $orquesta.add_instrumento(guitarra)
  "Agregando Cuerda"
end

get '/agregar/Percusion/:nombre' do
  n = params[:nombre]
  tambor = Viento.new(n)
  $orquesta.add_instrumento(tambor)
  "Agregando Viento"
end


get '/afinar' do
  output = StringIO.new
  $stdout = output
  $orquesta.afinar
  $stdout = STDOUT
  output.string
end

get '/tocar' do
  output = StringIO.new
  $stdout = output
  $orquesta.tocar
  $stdout = STDOUT
  output.string
end

set :port, 4568
