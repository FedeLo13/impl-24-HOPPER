using System;
using System.ComponentModel.DataAnnotations;

public class Persona
{
    [Required(ErrorMessage = "El nombre es obligatorio.")]
    public string? Nombre { get; set; }

    [Required(ErrorMessage = "El DNI es obligatorio.")]
    [StringLength(9, MinimumLength = 9, ErrorMessage = "El DNI debe tener 9 caracteres.")]
    public string? DNI { get; set; }

    [Range(18, 120, ErrorMessage = "La edad debe estar entre 18 y 120.")]
    public int Edad { get; set; }

    [DataType(DataType.Date, ErrorMessage = "Fecha de nacimiento no válida.")]
    public DateTime FechaNacimiento { get; set; }
}