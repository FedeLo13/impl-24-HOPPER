
# app.rb

require 'sinatra'
require_relative 'Adventure'

get '/' do
  erb :index
end

get '/realizar_acciones/:nom' do
  aventura = Aventura.new
  n = params[:nom]
  protagonista = case n
                 when 'Heroe'
                   Heroe.new
                 when 'Explorador'
                   Explorador.new
                 when 'Mago'
                   Mago.new
                 when 'Guerrero'
                   Guerrero.new
                 else
                   PersonajeAccion.new
                 end

  output = StringIO.new
  $stdout = output
  aventura.realizar_acciones(protagonista)
  $stdout = STDOUT
  output.string
end
