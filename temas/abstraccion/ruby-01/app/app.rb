require_relative '../src/figura'
require_relative '../src/robot'

# Prueba de las clases de Figura
rectangulo = Rectangulo.new(10, 5)
triangulo = Triangulo.new(10, 5)

puts "Área del rectángulo: #{rectangulo.area}"
puts "Área del triángulo: #{triangulo.area}"

# Prueba de la clase Robot
robot = Robot.new("T-800", "Titanio", 3)

robot.saludar
robot.hablar
3.times { robot.disparar_laser }
robot.disparar_laser