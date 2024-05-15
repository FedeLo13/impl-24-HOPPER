# Lambdas en Ruby #
## Ejemplo ##
Este ejemplo trata sobre un simulador en el que unos sensores registran la temperatura tanto en grados Celsius como en grados Fahrenheit mediante la programación reactiva y las funciones anónimas.

```ruby
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
```

## Explicación ##
```ruby
require 'rx'
```
Se importa la gema rx que incluye funciones que sirven para la programación reactiva.

```ruby
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
```
- Se define una función `simulate_temperature_sensor` que simula la generación de lecturas de temperatura de un sensor dado.
- `Rx::Observable.create do |observer|`: Se crea un observable perteneciente a la gema rx. Es una secuencia de eventos o valores que ocurren en el tiempo. Estos eventos pueden ser emitidos, consumidos y manipulados de manera asíncrona.
- Se crea un primer hilo `Thread.new do` para ejecutar la generación de lecturas de temperatura en paralelo.
Se realiza un bucle infinito `loop do` para generar las lecturas continuamente, se genera un valor aleatorio entre 10 y 45 `temperature_celsius = rand(10..45)` y se emite un evento con un hash que contiene el ID del sensor y la temperatura en Celsius `observer.on_next({ sensor_id: sensor_id, temperature_celsius: temperature_celsius })`. Por último, irá esperando un segundo antes de generar la próxima lectura `sleep(1)`.
- Se crea un segundo hilo que esperará 15 segundos `sleep(15)` antes de completar el observador `observer.on_completed` e indicar que se ha terminado de 'observar' esas lecturas.

```ruby
def run_temperature_monitoring_simulation
```
Se define la siguiente función para realizar la simulación.

```ruby
sensor1_observable = simulate_temperature_sensor(1)
sensor2_observable = simulate_temperature_sensor(2)
```
Se instancian dos observables que contendrán el hash con el ID del sensor y la temperatura en Celsius para cada sensor respectivamente.

```ruby
to_fahrenheit = ->(data) do
    temperature_fahrenheit = data[:temperature_celsius] * 9.0 / 5.0 + 32.0
    data.merge(temperature_fahrenheit: temperature_fahrenheit)
end
```
Se define la siguiente función anónima para convertir la temperatura de grados Celsius a grados Fahrenheit. Luego se crea una nueva variable con la temperatura en Fahrenheit y se añadirá al hash mediante la función merge.
El hash entonces contendrá el ID del sensor, la temperatura en Celsius y la temperatura en Fahrenheit.

```ruby
sensor1_with_fahrenheit = sensor1_observable.map(&to_fahrenheit)
sensor2_with_fahrenheit = sensor2_observable.map(&to_fahrenheit)
```
Se crean dos observables con los nuevos hashes que contendrán. Se utiliza el operador de map en el contexto del Observable para transformar el hash inicial `sensorX_observable` a un nuevo hash llamando a la función `to_fahrenheit`.

```ruby
is_anomalous = ->(data) { data[:temperature_celsius] > 35 }
```
Esta función lambda verificará si una lectura de temperatura es anómala, es decir, que su temperatura en Celsius sea mayor que 35.

```ruby
 subscribe_to_anomalous_readings = ->(sensor_id) do
    ->(data) { 
      puts "Sensor #{sensor_id} - Lectura anómala: #{data[:temperature_celsius]}°C / #{data[:temperature_fahrenheit]}°F\n" }
  end
```
Esta función lambda servirá para suscribirse a lecturas anómalas de temperatura.

```ruby
anomalous_readings1 = sensor1_with_fahrenheit.select(&is_anomalous)
anomalous_readings2 = sensor2_with_fahrenheit.select(&is_anomalous)
```
Se crean dos observables que solo contendrán aquellos hashes con lecturas anómalas mediante el operador de `select` que los filtrará.

```ruby
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
```
Se definen las dos suscripciones a los observables `anomalous_readingsX` y se especifican qué tienen qué hacer en cada caso de evento. Hay tres tipos de casos:
- Evento exitoso (on_next): llamará a la función lambda `subscribe_to_anomalous_readings` que imprimirá por pantalla las lecturas anómalas de un determinado sensor.
- Evento erróneo (on_error): se ejecutará si existe algún error en el flujo de datos.
- Evento completado (on_completed): se realizará cuando el flujo de datos ha finalizado correctamente para X sensor.

```ruby
sleep(18)

  
subscription1.dispose
subscription2.dispose
end
```
Se esperan 18 segundos para que se generen algunas lecturas anómalas.
Finalmente, con la función `dispose` se cancelan las suscripciones para que los observables terminen de monitorizar los eventos.

Nota: el programa dura 18 segundos pero se establece que a partir de los 15 segundos se complete el evento para que se pueda mostrar por pantalla el mensaje de `Sensor X - La secuencia ha finalizado'.

# Construir programa y pruebas #
Para verificar la corrección del ejemplo se han desarrollado unas pruebas. En ruby usamos para ello la gema `minitest` que permite, entre otras cosas, comparar flujos de salida. 
La prueba la puede ver desde aquí directamente con este enlace: [Tests](testLambdas.rb)

Para construir el programa y las pruebas se ha desarrollado un github Action, puede runnearlo manualmente desde
el siguiente enlace : [Action](../../../.github/workflows/lambdas.ruby.yml)

## Desplegar Web ##
Para desplegar la web necesitamos ejecutar el terraform (que despliega el [Dockerfile](Dockerfile)) con estos comandos:


```terraform
terraform init
terraform apply
```
Una vez que Terraform haya completado el despliegue, la web estará disponible en la siguiente dirección: 

`https:localhost/4568`

En caso de querer dejar libre el puerto, es necesario parar y eliminar el contenedor docker.
