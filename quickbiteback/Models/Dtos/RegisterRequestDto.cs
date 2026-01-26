using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class RegisterRequestDto
{
    [Required(ErrorMessage = "A teljes név megadása kötelező.")]
    [MaxLength(200)]
    public string FullName { get; set; } = null!;

    [Required(ErrorMessage = "Az email megadása kötelező.")]
    [EmailAddress(ErrorMessage = "Érvényes email címet adjon meg.")]
    public string Email { get; set; } = null!;

    [Required(ErrorMessage = "A jelszó megadása kötelező.")]
    [MinLength(6, ErrorMessage = "A jelszónak legalább 6 karakter hosszúnak kell lennie.")]
    public string Password { get; set; } = null!;
}
