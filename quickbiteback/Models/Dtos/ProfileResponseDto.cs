namespace quickbiteback.Models.Dtos;

public class ProfileResponseDto
{
    public int Id { get; set; }
    public string Name { get; set; } = null!;
    public string Email { get; set; } = null!;
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public string? Phone { get; set; }
    public string? AvatarUrl { get; set; }
    public string? AddressLine { get; set; }
    public string? City { get; set; }
    public string? ZipCode { get; set; }
    public int ReviewsCount { get; set; }
    public List<UserAddressDto> Addresses { get; set; } = new();
    public List<UserPaymentMethodDto> PaymentMethods { get; set; } = new();
}
