using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class CreateAddressDto
{
    [Required]
    [MaxLength(50)]
    public string Label { get; set; } = null!;

    [Required]
    [MaxLength(500)]
    public string AddressLine { get; set; } = null!;

    [Required]
    [MaxLength(100)]
    public string City { get; set; } = null!;

    [Required]
    [MaxLength(10)]
    public string ZipCode { get; set; } = null!;

    public bool IsDefault { get; set; }
}
