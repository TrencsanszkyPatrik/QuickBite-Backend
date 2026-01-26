namespace quickbiteback.Models.Dtos;

public class AuthResponseDto
{
    public int UserId { get; set; }
    public string Token { get; set; } = null!;
    public string Name { get; set; } = null!;
}
