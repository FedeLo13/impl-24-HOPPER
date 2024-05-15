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
