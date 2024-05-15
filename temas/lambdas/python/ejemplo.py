from functools import reduce

def asignacion():
    # Funcion lambda
    add = lambda x, y: x + y
    return add(3, 5)

def ordenSuperior():
    # Lista de números
    numbers = [1, 2, 3, 4, 5]
    return list(map(lambda x: x**2, numbers))

def ordenSuperior2():
    words = ["hello", "world", "python", "lambda", "example"]
    return list(filter(lambda x: len(x) > 5, words))

def condicionesTernarias():
    is_even = lambda x: True if x % 2 == 0 else False
    return is_even(4)

def funcionReduccion():
    numbers = [1, 2, 3, 4, 5]
    return reduce(lambda x, y: x + y, numbers)
