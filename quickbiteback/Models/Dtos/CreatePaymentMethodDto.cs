using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class CreatePaymentMethodDto
{
    [Required]
    [MaxLength(20)]
    public string Type { get; set; } = null!; // "card", "cash", "szep"

    [Required]
    [MaxLength(100)]
    public string DisplayName { get; set; } = null!;

    [MaxLength(4)]
    public string? LastFourDigits { get; set; }

    public bool IsDefault { get; set; }
}
