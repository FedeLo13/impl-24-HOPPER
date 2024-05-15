local EmailService = require("./temas/inyeccion/lua/email")
local App = require("./temas/inyeccion/lua/app")

-- Crear una instancia de EmailService
local emailService = EmailService:new()

-- Crear una instancia de App con la dependencia inyectada
local app = App:new(emailService)

-- Simular la notificación de un usuario
local user = { email = "usuario@example.com" }
app:notifyUser(user)
