using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class LoginRequestDto
{
    [Required(ErrorMessage = "Az email megadása kötelező.")]
    [EmailAddress(ErrorMessage = "Érvényes email címet adjon meg.")]
    public string Email { get; set; } = null!;

    [Required(ErrorMessage = "A jelszó megadása kötelező.")]
    public string Password { get; set; } = null!;
}
