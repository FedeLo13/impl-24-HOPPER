require 'rx'

# Simulación de lecturas de temperatura de sensores
def simulate_temperature_sensor(sensor_id)
  Rx::Observable.create do |observer|
    # Simulamos la generación de lecturas de temperatura cada segundo
    Thread.new do
      loop do
        temperature = rand(10..45)
        
        observer.on_next({ sensor_id: sensor_id, temperature: temperature }) #Emite un hash con el ID del sensor y la temperatura
        sleep(1)
      end
    end
  end
end

# Creamos observables para dos sensores simulados
sensor1_observable = simulate_temperature_sensor(1)
sensor2_observable = simulate_temperature_sensor(2)

# Lambda para verificar si una lectura es anómala
is_anomalous = ->(data) { data[:temperature] > 35 }

# Lambda para suscribirse a lecturas anómalas
subscribe_to_anomalous_readings = ->(sensor_id) do
  ->(data) { puts "Sensor #{sensor_id} - Lectura anómala: #{data[:temperature]}" }
end



# Aplicamos la lambda de verificación a ambos flujos de datos
anomalous_readings1 = sensor1_observable.select(&is_anomalous)
anomalous_readings2 = sensor2_observable.select(&is_anomalous)

# Nos suscribimos a los flujos de datos de lecturas anómalas
subscription1 = anomalous_readings1.subscribe(
    subscribe_to_anomalous_readings.call(1), #on_next
    ->(error) { puts "Error en el sensor 1: #{error}"},  #on_error
    -> { puts "Sensor 1 - La secuencia ha finalizado"}  #on_completed
)

subscription2 = anomalous_readings2.subscribe(
    subscribe_to_anomalous_readings.call(2), #on_next
    ->(error) { puts "Error en el sensor 2: #{error}"},  #on_error
    -> { puts "Sensor 2 - La secuencia ha finalizado"}  #on_completed
)

# Esperamos un tiempo para que se emitan algunas lecturas anómalas
sleep(10)

# Cancelamos las suscripciones después de un tiempo
subscription1.dispose
subscription2.dispose

