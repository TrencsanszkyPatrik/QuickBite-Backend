using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class DeleteAccountDto
{
    [Required(ErrorMessage = "A jelszó megadása kötelező a fiók törléséhez.")]
    public string Password { get; set; } = null!;
}
