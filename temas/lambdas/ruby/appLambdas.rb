require 'sinatra'
require_relative 'lambdas.rb'

get '/' do
    erb :index
end

get '/IniciarSimulador' do
    output = StringIO.new
    $stdout = output
    run_temperature_monitoring_simulation
    $stdout = STDOUT
    output.string
end

set :port, 4568