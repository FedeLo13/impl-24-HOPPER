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
