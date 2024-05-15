# Inyección en Lua #
## Ejemplo ##
Este ejemplo consiste en una app que enviará un mensaje a un usuario dado su correo electrónico. Para poder crear una instancia de App se necesitará disponer del correo electrónico. Por ello, en vez de crear directamente una instancia de `EmailService` dentro de `App`, se utilizará el principio de Inversión de Control (IoC) para pasarle una instancia de `EmailService` como una dependencia cuando se crea una instancia de `App`, entonces se reducirá el acomplamiento entre clases y permitirá que `App` sea más flexible y reutilizable. Para la prueba del ejemplo se dispone de un [main](main.lua) y los módulos de [email](email.lua) y [app](app.lua).


```lua
-- main.lua
local EmailService = require("./temas/inyeccion/lua/email")
local App = require("./temas/inyeccion/lua/app")

-- Crear una instancia de EmailService
local emailService = EmailService:new()

-- Crear una instancia de App con la dependencia inyectada
local app = App:new(emailService)

-- Simular la notificación de un usuario
local user = { email = "usuario@example.com" }
app:notifyUser(user)
```

## Explicación ##
El ejemplo consta de dos módulos:
- `EmailService`: una estructura básica para un servicio de correo electrónico.
- `App`: una aplicación que utiliza un servicio de correo electrónico para notificar a los usuarios.

### Módulo email ###
```lua
local EmailService = {}

function EmailService:new()
    local newObj = {}
    self.__index = self
    return setmetatable(newObj, self)
end

function EmailService:sendEmail(to, subject, body)
    -- Lógica para enviar el correo electrónico
    print("Enviando correo a:", to)
    print("Asunto:", subject)
    print("Cuerpo:", body)
end

return EmailService
```
- Definición del módulo `EmailService`: Se crea una tabla vacía llamada `EmailService` utilizando la notación de llaves {}. Esta tabla actuará como el espacio de nombres para el módulo y contendrá todas las funciones y datos relacionados con el servicio de correo electrónico.

- Constructor `new()`: Este método se utiliza para crear nuevas instancias del servicio de correo electrónico. Dentro del método `new()`, se crea un nuevo objeto vacío llamado `newObj`. Luego, se establece la metatabla `__index` del objeto `newObj` para que apunte al propio módulo `EmailService`, lo que permite acceder a los métodos del módulo desde las instancias creadas. Finalmente, se utiliza la función `setmetatable()` para asignar la metatabla al objeto `newObj` y se devuelve este objeto.

- Método `sendEmail()`: Este método toma tres parámetros: `to` (destinatario del correo electrónico), `subject` (asunto del correo electrónico) y `body` (cuerpo del correo electrónico). Se imprime en la consola la información del correo electrónico que se enviaría.

- Exportación del módulo: Se utiliza return para exportar el módulo `EmailService`, lo que permite que sea utilizado en otros archivos Lua.

### Módulo app ###
```lua
local App = {}

function App:new(emailService)
    local newObj = { emailService = emailService }
    self.__index = self
    return setmetatable(newObj, self)
end

function App:notifyUser(user)
    local to = user.email
    local subject = "¡Hola!"
    local body = "Este es un mensaje de notificación."
    self.emailService:sendEmail(to, subject, body)
end

return App
```
- Definición del módulo `App`: Se crea una tabla vacía llamada App utilizando la notación de llaves {}. Al igual que en el ejemplo anterior, esta tabla actuará como el espacio de nombres para el módulo y contendrá todas las funciones y datos relacionados con la aplicación.

- Constructor `new()`: Este método se utiliza para crear nuevas instancias de la aplicación. Toma un parámetro `emailService`, que es el servicio de correo electrónico que la aplicación utilizará para enviar correos electrónicos. En este punto, se realiza la inyección de dependencia ya que la aplicación no instancia directamente el servicio de correo electrónico, sino que espera que se le pase como argumento. Se crea un nuevo objeto llamado `newObj` que contiene una referencia al servicio de correo electrónico proporcionado. Luego, se establece la metatabla `__index` del objeto `newObj` para que apunte al propio módulo `App`, lo que permite acceder a los métodos del módulo desde las instancias creadas. Finalmente, se utiliza la función `setmetatable()` para asignar la metatabla al objeto `newObj` y se devuelve este objeto.

- Método `notifyUser()`: Este método toma un parámetro `user`, que representa al usuario al que se va a notificar. Se establecen los valores `to` (dirección de correo electrónico del usuario), `subject` (asunto) y `body` (cuerpo) del correo electrónico a enviar. Luego, se utiliza el servicio de correo electrónico proporcionado para enviar el correo electrónico al usuario utilizando el método `sendEmail()` del servicio.

- Exportación del módulo: Se utiliza return para exportar el módulo App, lo que permite que sea requerido y utilizado en otros archivos Lua.

# Construir programa y pruebas
Se ha desarrollado un test unitario para probar el ejemplo. Se han empleado módulos específicos para la realización de las pruebas como son `luaunit` y `luassert`. Para acceder al código del test: [test](../../../temas/inyeccion/lua/testInyeccion.lua)

Para construir el programa y las pruebas se ha desarrollado un github Action, puede runnearlo manualmente desde
el siguiente enlace : [Action](../../../.github/workflows/inyeccion.lua.yml)

