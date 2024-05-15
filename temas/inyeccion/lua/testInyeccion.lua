local lu = require('luaunit')
local luassert = require('luassert')
local EmailService = require('./temas/inyeccion/lua/email')
local App = require('./temas/inyeccion/lua/app')

TestApp = {}

function TestApp:testNotifyUser()
    local emailServiceMock = {
        sendEmailCalled = false,
        sendEmail = function(self, to, subject, body)
            self.sendEmailCalled = true
            self.to = to
            self.subject = subject
            self.body = body
        end
    }

    local app = App:new(emailServiceMock)
    local user = { email = "usuario@example.com" }
    app:notifyUser(user)

    luassert.is_true(emailServiceMock.sendEmailCalled)
    luassert.are_equal("usuario@example.com", emailServiceMock.to)
    luassert.are_equal("¡Hola!", emailServiceMock.subject)
    luassert.are_equal("Este es un mensaje de notificación.", emailServiceMock.body)
end

-- Ejecutar los tests
os.exit( lu.LuaUnit.run() )
