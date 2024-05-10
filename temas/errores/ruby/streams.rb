
# Este script es un ejemplo de como se puede utilizar
# Optional y Rx para manejar errores en flujos de datos.
# En este caso, se tiene un flujo de numeros que se dividen entre si.
# Si el divisor es 0, se omite el resultado y se continua con el siguiente numero.
# Al final, se imprime el resultado de las divisiones validas.

require 'optional'
require 'rx'
require './calculator'

calculator = Calculator.new

numbers = Rx::Observable.from_array([1, 0, 2, 3, 0, 4])

valid_results = []

numbers
  .map do |number|
    x = calculator.divide(number, number + 1)
    if x.some?
      puts "La division entre #{number} y #{number + 1} es valida."
      x.value
    else
      next
    end
  end
  .subscribe(
    lambda { |result|
      valid_results << result if result
    },
    lambda { # On error
      puts "Error en el flujo de datos."
    },
    lambda { # On complete
      puts "Flujo de datos completado: #{valid_results.inspect}"
    }
  )
