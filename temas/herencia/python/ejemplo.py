class Animal:
    def __init__(self, nombre):
        self.nombre = nombre

    def mostrar_nombre(self):
        return self.nombre


class Volador:
    def __init__(self, nombre, raza):
        self.raza = raza
        self.nombre = nombre
    
    def mostrar_nombre(self):
        return self.nombre

    def volar(self):
        return "El animal puede volar"

    def mostrar_raza(self):
        return self.raza


class Nadador:
    def __init__(self, nombre, raza):
        self.raza = raza
        self.nombre = nombre
        
    def mostrar_nombre(self):
        return self.nombre
        
    def nadar(self):
        return "El animal puede nadar"

    def mostrar_raza(self):
        return self.raza


class Ave(Animal, Volador):
    def __init__(self, nombre, raza):
        Animal.__init__(self, nombre)
        Volador.__init__(self, nombre, raza)

    def accion(self):
        return "Soy un ave" + "\n" + Volador.volar(self)


class Pez(Nadador, Animal):
    def __init__(self, nombre, raza):
        Animal.__init__(self, nombre)
        Nadador.__init__(self, nombre, raza)


