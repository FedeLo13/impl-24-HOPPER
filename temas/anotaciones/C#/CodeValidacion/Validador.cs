using System.ComponentModel.DataAnnotations;
public class Validador{
    public void validar(Persona p){
        Console.WriteLine($"VALIDANDO A {p.Nombre}...");
            // Validación de la persona
            var context = new ValidationContext(p, serviceProvider: null, items: null);
            var results = new System.Collections.Generic.List<ValidationResult>();

            bool isValid = Validator.TryValidateObject(p, context, results, validateAllProperties: true);

            if (!isValid)
            {
                foreach (var validationResult in results)
                {
                    Console.WriteLine(validationResult.ErrorMessage);
                }
            }
            else
            {
                Console.WriteLine("La persona es válida.\n\n");
            }
    }
}