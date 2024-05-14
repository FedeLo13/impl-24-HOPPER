# Crear instancias de tropas
bruja = Bruja.new("Morgana")
arquera = Arquera.new("Diana")
gigante = Gigante.new("Goliat")

# Crear una instancia de Clan
clan = Clan.new

# Añadir tropas al clan
clan.add_tropa_ataque(bruja)
clan.add_tropa_ataque(arquera)
clan.add_tropa_defensa(gigante)

# Simular un ataque
puts "=== El clan ataca ==="
clan.atacar

# Simular una defensa
puts "\n=== El clan defiende ==="
clan.defender

# Crear instancias de Horno y Cocina
horno = Horno.new
cocina = Cocina.new(horno)

# Cocinar algo
puts "\n=== Usando la cocina ==="
cocina.cocinar("pizza")