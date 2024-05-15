require 'minitest/autorun'
require_relative 'lambdas.rb' 

class TestTemperatureSensorSimulation < Minitest::Test
  def test_simulate_temperature_sensor
    sensor_id = 1
    sensor_data = []

    # Observador para capturar datos del sensor
    observer = Rx::Observer.create(
      lambda { |data| sensor_data << data },
      lambda { |error| puts "Error en el sensor: #{error}" },
      lambda { puts "La secuencia del sensor ha finalizado\n" }
    )

    # Simulamos el sensor
    simulate_temperature_sensor(sensor_id).subscribe(observer)

    # Esperamos un tiempo para que se capturen algunas lecturas
    sleep(5)

    # Comprobamos si se han capturado algunos datos del sensor
    assert_operator sensor_data.size, :>, 0
  end

  def test_run_temperature_monitoring_simulation
    # Capturamos la salida estándar para verificar los mensajes
    output = capture_io do
      run_temperature_monitoring_simulation
    end

    # Comprobamos si se imprimieron los mensajes de finalización de la simulación para ambos sensores
    assert_match(/Sensor 1 - La secuencia ha finalizado\n/, output[0])
    assert_match(/Sensor 2 - La secuencia ha finalizado\n/, output[0])
  end
end
