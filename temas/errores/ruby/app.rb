
# app.rb

require 'sinatra'
require_relative 'calculator'


calc = Calculator.new

get '/' do
  erb :index
end

get '/sumar/:a/:b' do
  a = params[:a].to_f
  b = params[:b].to_f
  calc.sum(a, b).to_s
end

get '/restar/:a/:b' do
  a = params[:a].to_f
  b = params[:b].to_f
  calc.subtract(a, b).to_s
end

get '/multiplicar/:a/:b' do
  a = params[:a].to_f
  b = params[:b].to_f
  calc.multiply(a, b).to_s
end

get '/dividir/:a/:b' do
  a = params[:a].to_f
  b = params[:b].to_f
  calc.divide(a, b).to_s
end

get '/potencia/:base/:exponente' do
  base = params[:base].to_f
  exponente = params[:exponente].to_f
  calc.power(base, exponente).to_s
end

set :port, 4567
