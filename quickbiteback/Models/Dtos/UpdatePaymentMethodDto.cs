using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class UpdatePaymentMethodDto
{
    [MaxLength(20)]
    public string? Type { get; set; }

    [MaxLength(100)]
    public string? DisplayName { get; set; }

    [MaxLength(4)]
    public string? LastFourDigits { get; set; }

    public bool? IsDefault { get; set; }
}
