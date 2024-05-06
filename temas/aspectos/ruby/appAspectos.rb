require 'sinatra'

require_relative 'aspectos.rb'

$userHigh = nil

get '/' do
  erb :index
end

get '/CrearUsuario/:username/:password' do
  username_ = params[:username]
  password_ = params[:password]
  $user = User.new(username_, password_)
  $userHigh = $user
end

get '/IniciarSesion/:username/:password' do
  username_ = params[:username]
  password_ = params[:password]
  output = StringIO.new
  $stdout = output
  
  $userHigh.login_account(username_, password_)
  $stdout = STDOUT
  output.string
end

get '/CambiarContraseña/:password' do
  new_password = params[:password]
  output = StringIO.new
  $stdout = output
  $userHigh.update_account(new_password)
  $stdout = STDOUT
  output.string
end


set :port, 4568