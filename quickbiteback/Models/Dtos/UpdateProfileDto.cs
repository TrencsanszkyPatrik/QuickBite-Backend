using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos;

public class UpdateProfileDto
{
    [MaxLength(200)]
    public string? Name { get; set; }

    [MaxLength(30)]
    public string? Phone { get; set; }

    [MaxLength(500)]
    public string? AvatarUrl { get; set; }

    [MaxLength(300)]
    public string? AddressLine { get; set; }

    [MaxLength(100)]
    public string? City { get; set; }

    [MaxLength(10)]
    public string? ZipCode { get; set; }
}
