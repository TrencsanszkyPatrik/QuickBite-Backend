using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class ChangePasswordDto
{
    [Required(ErrorMessage = "A jelenlegi jelszó kötelező.")]
    public string CurrentPassword { get; set; } = null!;

    [Required(ErrorMessage = "Az új jelszó kötelező.")]
    [MinLength(6, ErrorMessage = "Az új jelszónak legalább 6 karakter hosszúnak kell lennie.")]
    public string NewPassword { get; set; } = null!;
}
