using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using quickbiteback.Models;
using quickbiteback.Models.Dtos;
using BCrypt.Net;

namespace quickbiteback.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AuthController : ControllerBase
{
    private readonly QuickBiteDbContext _context;
    private readonly IConfiguration _config;

    public AuthController(QuickBiteDbContext context, IConfiguration config)
    {
        _context = context;
        _config = config;
    }

    /// <summary>
    /// Bejelentkezés email + jelszóval.
    /// </summary>
    [HttpPost("login")]
    public async Task<ActionResult<AuthResponseDto>> Login([FromBody] LoginRequestDto dto)
    {
        if (string.IsNullOrWhiteSpace(dto.Email) || string.IsNullOrWhiteSpace(dto.Password))
            return BadRequest(new { message = "Kérjük, töltse ki az összes mezőt!" });

        if (!dto.Email.Contains('@'))
            return BadRequest(new { message = "Kérjük, adjon meg egy érvényes email címet!" });

        var user = await _context.users
            .AsNoTracking()
            .FirstOrDefaultAsync(u => u.email == dto.Email.Trim());

        if (user == null)
            return Unauthorized(new { message = "Hibás email vagy jelszó." });

        if (!BCrypt.Net.BCrypt.Verify(dto.Password, user.password))
            return Unauthorized(new { message = "Hibás email vagy jelszó." });

        var token = CreateToken(user.id, user.email, user.name);
        return Ok(new AuthResponseDto { Token = token, Name = user.name });
    }

    /// <summary>
    /// Regisztráció teljes név, email és jelszóval.
    /// </summary>
    [HttpPost("register")]
    public async Task<ActionResult<AuthResponseDto>> Register([FromBody] RegisterRequestDto dto)
    {
        if (string.IsNullOrWhiteSpace(dto.FullName) || string.IsNullOrWhiteSpace(dto.Email) ||
            string.IsNullOrWhiteSpace(dto.Password))
            return BadRequest(new { message = "Kérjük, töltse ki az összes mezőt!" });

        if (!dto.Email.Contains('@'))
            return BadRequest(new { message = "Kérjük, adjon meg egy érvényes email címet!" });

        if (dto.Password.Length < 6)
            return BadRequest(new { message = "A jelszónak legalább 6 karakter hosszúnak kell lennie!" });

        var emailNorm = dto.Email.Trim();
        var exists = await _context.users.AnyAsync(u => u.email == emailNorm);
        if (exists)
            return BadRequest(new { message = "Ez az email cím már regisztrálva van." });

        var hashed = BCrypt.Net.BCrypt.HashPassword(dto.Password, BCrypt.Net.BCrypt.GenerateSalt(12));
        var user = new users
        {
            name = dto.FullName.Trim(),
            email = emailNorm,
            password = hashed,
            created_at = DateTime.UtcNow.Date
        };

        _context.users.Add(user);
        await _context.SaveChangesAsync();

        var token = CreateToken(user.id, user.email, user.name);
        return Ok(new AuthResponseDto { Token = token, Name = user.name });
    }

    private string CreateToken(int userId, string email, string name)
    {
        var key = _config["Jwt:Key"] ?? "QuickBite-SuperSecretKey-Min32Chars!!";
        var keyBytes = Encoding.UTF8.GetBytes(key);
        if (keyBytes.Length < 32)
        {
            var padded = new byte[32];
            Buffer.BlockCopy(keyBytes, 0, padded, 0, keyBytes.Length);
            keyBytes = padded;
        }

        var creds = new SigningCredentials(
            new SymmetricSecurityKey(keyBytes),
            SecurityAlgorithms.HmacSha256);

        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier, userId.ToString()),
            new Claim(ClaimTypes.Email, email),
            new Claim(ClaimTypes.Name, name)
        };

        var token = new JwtSecurityToken(
            issuer: _config["Jwt:Issuer"] ?? "QuickBite",
            audience: _config["Jwt:Audience"] ?? "QuickBite",
            claims: claims,
            expires: DateTime.UtcNow.AddDays(7),
            signingCredentials: creds);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
