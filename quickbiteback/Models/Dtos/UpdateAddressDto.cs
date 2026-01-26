using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class UpdateAddressDto
{
    [MaxLength(50)]
    public string? Label { get; set; }

    [MaxLength(500)]
    public string? AddressLine { get; set; }

    [MaxLength(100)]
    public string? City { get; set; }

    [MaxLength(10)]
    public string? ZipCode { get; set; }

    public bool? IsDefault { get; set; }
}
