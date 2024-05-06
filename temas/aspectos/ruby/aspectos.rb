require 'aquarium'

class Auditor
  def self.log(message)
    puts "[AUDIT] #{message}"
  end
end

class User
  attr_accessor :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  def login_account(username, password)
    if @username == username && @password == password
      puts "¡Bienvenido #{username}!"
      # Lógica para iniciar sesión...
      
    else
      puts "Nombre de usuario o contraseña incorrectos."
    end
  end

  def update_account(password)
    @password = password
    puts "La contraseña se ha modificado"
    # Lógica para actualizar la información del usuario...
  end
end

# Configuración de aspectos con Aquarium
include Aquarium::Aspects

Aspect.new :after, :calls_to => :login_account, :for_types => [User] do |join_point, user,_, password|
  if password == user.password
    Auditor.log("El usuario '#{user.username}' ha iniciado sesión correctamente")
  else
    Auditor.log("Intento de inicio de sesión fallido para el usuario '#{user.username}'")
  end
end

Aspect.new :after, :calls_to => :update_account, :for_types => [User] do |join_point, user|
  Auditor.log("El usuario '#{user.username}' ha actualizado su contraseña de cuenta a '#{user.password}'")
end

# Secuencia de datos para crear múltiples usuarios y actualizar su información
users_data = [
  User.new("Juanito32", "contraseña123"),
  User.new("Alberto33", "clave456"),
  User.new("Antonito35", "secreto789")
]

# Uso de los usuarios
users_data.each do |user|
  puts "Nombre de cuenta: #{user.username}"
  user.login_account(user.username, user.password) # Se pasa también la contraseña
end

# Actualización de la contraseña de la cuenta
usuario2 = users_data[1]
new_password = "secrete"
error_password = "secrete1"
usuario2.update_account(new_password)
usuario2.login_account(usuario2.username, new_password)
usuario2.login_account(usuario2.username, error_password)
