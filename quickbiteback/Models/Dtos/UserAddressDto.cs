namespace quickbiteback.Models.Dtos;

public class UserAddressDto
{
    public int Id { get; set; }
    public string Label { get; set; } = null!;
    public string AddressLine { get; set; } = null!;
    public string City { get; set; } = null!;
    public string ZipCode { get; set; } = null!;
    public bool IsDefault { get; set; }
}
