namespace quickbiteback.Models.Dtos;

public class UserPaymentMethodDto
{
    public int Id { get; set; }
    public string Type { get; set; } = null!;
    public string DisplayName { get; set; } = null!;
    public string? LastFourDigits { get; set; }
    public bool IsDefault { get; set; }
}
