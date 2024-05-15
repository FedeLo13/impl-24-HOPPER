require 'rx'

# Simulación de lecturas de temperatura de sensores
def simulate_temperature_sensor(sensor_id)
  Rx::Observable.create do |observer|
    # Simulamos la generación de lecturas de temperatura cada segundo
    Thread.new do
      loop do
        temperature_celsius = rand(10..45)
        observer.on_next({ sensor_id: sensor_id, temperature_celsius: temperature_celsius }) # Emite un hash con el ID del sensor y la temperatura en Celsius
        sleep(1)
      end
    end

    Thread.new do
      sleep(15)
      observer.on_completed
    end
  end
end

def run_temperature_monitoring_simulation

  # Creamos observables para dos sensores simulados
  sensor1_observable = simulate_temperature_sensor(1)
  sensor2_observable = simulate_temperature_sensor(2)

  # Lambda para convertir la temperatura a grados Fahrenheit
  to_fahrenheit = ->(data) do
    temperature_fahrenheit = data[:temperature_celsius] * 9.0 / 5.0 + 32.0
    data.merge(temperature_fahrenheit: temperature_fahrenheit)
  end

  # Aplicamos el operador 'map' para convertir la temperatura a grados Fahrenheit
  sensor1_with_fahrenheit = sensor1_observable.map(&to_fahrenheit)
  sensor2_with_fahrenheit = sensor2_observable.map(&to_fahrenheit)

  # Lambda para verificar si una lectura es anómala
  is_anomalous = ->(data) { data[:temperature_celsius] > 35 }

  # Lambda para suscribirse a lecturas anómalas
  subscribe_to_anomalous_readings = ->(sensor_id) do
    ->(data) { 
      puts "Sensor #{sensor_id} - Lectura anómala: #{data[:temperature_celsius]}°C / #{data[:temperature_fahrenheit]}°F\n" }
  end

  # Aplicamos la lambda de verificación a ambos flujos de datos
  anomalous_readings1 = sensor1_with_fahrenheit.select(&is_anomalous)
  anomalous_readings2 = sensor2_with_fahrenheit.select(&is_anomalous)

  # Nos suscribimos a los flujos de datos de lecturas anómalas
  subscription1 = anomalous_readings1.subscribe(
    subscribe_to_anomalous_readings.call(1), # on_next
    ->(error) { puts "Error en el sensor 1: #{error}" },  # on_error
    -> { puts "Sensor 1 - La secuencia ha finalizado\n" }  # on_completed
  )

  subscription2 = anomalous_readings2.subscribe(
    subscribe_to_anomalous_readings.call(2), # on_next
    ->(error) { puts "Error en el sensor 2: #{error}" },  # on_error
    -> { puts "Sensor 2 - La secuencia ha finalizado\n" }  # on_completed
  )

  # Esperamos un tiempo para que se emitan algunas lecturas anómalas
  sleep(18)

  # Cancelamos las suscripciones después de un tiempo
  subscription1.dispose
  subscription2.dispose
end


