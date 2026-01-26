using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using quickbiteback.Models;
using quickbiteback.Models.Dtos;

namespace quickbiteback.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class ProfileController : ControllerBase
{
    private readonly QuickBiteDbContext _context;

    public ProfileController(QuickBiteDbContext context)
    {
        _context = context;
    }

    private int? GetUserId()
    {
        var idStr = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        return int.TryParse(idStr, out var id) ? id : null;
    }

    private static UserAddressDto ToAddressDto(user_addresses a) => new()
    {
        Id = a.id,
        Label = a.label,
        AddressLine = a.address_line,
        City = a.city,
        ZipCode = a.zip_code,
        IsDefault = a.is_default
    };

    private static UserPaymentMethodDto ToPaymentMethodDto(user_payment_methods p) => new()
    {
        Id = p.id,
        Type = p.type,
        DisplayName = p.display_name,
        LastFourDigits = p.last_four_digits,
        IsDefault = p.is_default
    };

    private async Task<ProfileResponseDto> BuildProfileResponseAsync(int userId, users? user, int reviewsCount)
    {
        var addresses = await _context.user_addresses
            .AsNoTracking()
            .Where(a => a.user_id == userId)
            .OrderByDescending(a => a.is_default)
            .ThenBy(a => a.label)
            .ToListAsync();
        var paymentMethods = await _context.user_payment_methods
            .AsNoTracking()
            .Where(p => p.user_id == userId)
            .OrderByDescending(p => p.is_default)
            .ThenBy(p => p.id)
            .ToListAsync();

        return new ProfileResponseDto
        {
            Id = user!.id,
            Name = user.name,
            Email = user.email,
            CreatedAt = user.created_at,
            UpdatedAt = user.updated_at,
            Phone = user.phone,
            AvatarUrl = user.avatar_url,
            AddressLine = user.address_line,
            City = user.city,
            ZipCode = user.zip_code,
            ReviewsCount = reviewsCount,
            Addresses = addresses.Select(ToAddressDto).ToList(),
            PaymentMethods = paymentMethods.Select(ToPaymentMethodDto).ToList()
        };
    }

    /// <summary>
    /// Bejelentkezett felhasználó profiljának lekérdezése (címekkel és fizetési módokkal).
    /// </summary>
    [HttpGet("me")]
    public async Task<ActionResult<ProfileResponseDto>> GetMe()
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var user = await _context.users
            .AsNoTracking()
            .FirstOrDefaultAsync(u => u.id == userId);
        if (user == null)
            return NotFound();

        var reviewsCount = await _context.reviews.CountAsync(r => r.user_id == userId.Value);
        var dto = await BuildProfileResponseAsync(userId.Value, user, reviewsCount);
        return Ok(dto);
    }

    /// <summary>
    /// Bejelentkezett felhasználó profiljának frissítése.
    /// </summary>
    [HttpPatch("me")]
    public async Task<ActionResult<ProfileResponseDto>> UpdateMe([FromBody] UpdateProfileDto dto)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var user = await _context.users.FindAsync(userId);
        if (user == null)
            return NotFound();

        if (!string.IsNullOrWhiteSpace(dto.Name))
            user.name = dto.Name.Trim();
        if (dto.Phone != null)
            user.phone = string.IsNullOrWhiteSpace(dto.Phone) ? null : dto.Phone.Trim();
        if (dto.AvatarUrl != null)
            user.avatar_url = string.IsNullOrWhiteSpace(dto.AvatarUrl) ? null : dto.AvatarUrl.Trim();
        if (dto.AddressLine != null)
            user.address_line = string.IsNullOrWhiteSpace(dto.AddressLine) ? null : dto.AddressLine.Trim();
        if (dto.City != null)
            user.city = string.IsNullOrWhiteSpace(dto.City) ? null : dto.City.Trim();
        if (dto.ZipCode != null)
            user.zip_code = string.IsNullOrWhiteSpace(dto.ZipCode) ? null : dto.ZipCode.Trim();

        user.updated_at = DateTime.UtcNow;
        await _context.SaveChangesAsync();

        var reviewsCount = await _context.reviews.CountAsync(r => r.user_id == user.id);
        return Ok(await BuildProfileResponseAsync(user.id, user, reviewsCount));
    }

    // ========== CÍMEK ==========

    [HttpPost("addresses")]
    public async Task<ActionResult<UserAddressDto>> CreateAddress([FromBody] CreateAddressDto dto)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        if (dto.IsDefault)
        {
            foreach (var a in await _context.user_addresses.Where(a => a.user_id == userId).ToListAsync())
                a.is_default = false;
        }

        var addr = new user_addresses
        {
            user_id = userId.Value,
            label = dto.Label.Trim(),
            address_line = dto.AddressLine.Trim(),
            city = dto.City.Trim(),
            zip_code = dto.ZipCode.Trim(),
            is_default = dto.IsDefault
        };
        _context.user_addresses.Add(addr);
        await _context.SaveChangesAsync();
        return Created($"/api/Profile/addresses/{addr.id}", ToAddressDto(addr));
    }

    [HttpPatch("addresses/{id:int}")]
    public async Task<ActionResult<UserAddressDto>> UpdateAddress(int id, [FromBody] UpdateAddressDto dto)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var addr = await _context.user_addresses.FirstOrDefaultAsync(a => a.id == id && a.user_id == userId);
        if (addr == null)
            return NotFound();

        if (!string.IsNullOrWhiteSpace(dto.Label))
            addr.label = dto.Label.Trim();
        if (dto.AddressLine != null)
            addr.address_line = string.IsNullOrWhiteSpace(dto.AddressLine) ? addr.address_line : dto.AddressLine.Trim();
        if (dto.City != null)
            addr.city = string.IsNullOrWhiteSpace(dto.City) ? addr.city : dto.City.Trim();
        if (dto.ZipCode != null)
            addr.zip_code = string.IsNullOrWhiteSpace(dto.ZipCode) ? addr.zip_code : dto.ZipCode.Trim();
        if (dto.IsDefault == true)
        {
            foreach (var a in await _context.user_addresses.Where(a => a.user_id == userId).ToListAsync())
                a.is_default = false;
            addr.is_default = true;
        }

        await _context.SaveChangesAsync();
        return Ok(ToAddressDto(addr));
    }

    [HttpDelete("addresses/{id:int}")]
    public async Task<IActionResult> DeleteAddress(int id)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var addr = await _context.user_addresses.FirstOrDefaultAsync(a => a.id == id && a.user_id == userId);
        if (addr == null)
            return NotFound();

        _context.user_addresses.Remove(addr);
        await _context.SaveChangesAsync();
        return NoContent();
    }

    // ========== FIZETÉSI MÓDOK ==========

    [HttpPost("payment-methods")]
    public async Task<ActionResult<UserPaymentMethodDto>> CreatePaymentMethod([FromBody] CreatePaymentMethodDto dto)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var type = dto.Type.Trim().ToLowerInvariant();
        if (type != "card" && type != "cash" && type != "szep")
            return BadRequest(new { message = "Érvényes típus: card, cash, szep." });

        if (dto.IsDefault)
        {
            foreach (var p in await _context.user_payment_methods.Where(p => p.user_id == userId).ToListAsync())
                p.is_default = false;
        }

        var pm = new user_payment_methods
        {
            user_id = userId.Value,
            type = type,
            display_name = dto.DisplayName.Trim(),
            last_four_digits = string.IsNullOrWhiteSpace(dto.LastFourDigits) ? null : dto.LastFourDigits.Trim(),
            is_default = dto.IsDefault
        };
        _context.user_payment_methods.Add(pm);
        await _context.SaveChangesAsync();
        return Created($"/api/Profile/payment-methods/{pm.id}", ToPaymentMethodDto(pm));
    }

    [HttpPatch("payment-methods/{id:int}")]
    public async Task<ActionResult<UserPaymentMethodDto>> UpdatePaymentMethod(int id, [FromBody] UpdatePaymentMethodDto dto)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var pm = await _context.user_payment_methods.FirstOrDefaultAsync(p => p.id == id && p.user_id == userId);
        if (pm == null)
            return NotFound();

        if (!string.IsNullOrWhiteSpace(dto.Type))
        {
            var type = dto.Type.Trim().ToLowerInvariant();
            if (type != "card" && type != "cash" && type != "szep")
                return BadRequest(new { message = "Érvényes típus: card, cash, szep." });
            pm.type = type;
        }
        if (dto.DisplayName != null)
            pm.display_name = string.IsNullOrWhiteSpace(dto.DisplayName) ? pm.display_name : dto.DisplayName.Trim();
        if (dto.LastFourDigits != null)
            pm.last_four_digits = string.IsNullOrWhiteSpace(dto.LastFourDigits) ? null : dto.LastFourDigits.Trim();
        if (dto.IsDefault == true)
        {
            foreach (var p in await _context.user_payment_methods.Where(p => p.user_id == userId).ToListAsync())
                p.is_default = false;
            pm.is_default = true;
        }

        await _context.SaveChangesAsync();
        return Ok(ToPaymentMethodDto(pm));
    }

    [HttpDelete("payment-methods/{id:int}")]
    public async Task<IActionResult> DeletePaymentMethod(int id)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var pm = await _context.user_payment_methods.FirstOrDefaultAsync(p => p.id == id && p.user_id == userId);
        if (pm == null)
            return NotFound();

        _context.user_payment_methods.Remove(pm);
        await _context.SaveChangesAsync();
        return NoContent();
    }

    // ========== JELSZÓ MEGVÁLTOZTATÁS ==========

    /// <summary>
    /// Bejelentkezett felhasználó jelszavának megváltoztatása.
    /// </summary>
    [HttpPatch("me/password")]
    public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordDto dto)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        if (string.IsNullOrWhiteSpace(dto.NewPassword) || dto.NewPassword.Length < 6)
            return BadRequest(new { message = "Az új jelszónak legalább 6 karakter hosszúnak kell lennie." });

        var user = await _context.users.FindAsync(userId);
        if (user == null)
            return NotFound();

        if (!BCrypt.Net.BCrypt.Verify(dto.CurrentPassword, user.password))
            return BadRequest(new { message = "A jelenlegi jelszó nem megfelelő." });

        user.password = BCrypt.Net.BCrypt.HashPassword(dto.NewPassword, BCrypt.Net.BCrypt.GenerateSalt(12));
        user.updated_at = DateTime.UtcNow;
        await _context.SaveChangesAsync();
        return Ok(new { message = "A jelszó sikeresen megváltozott." });
    }

    // ========== FIÓK TÖRLÉS ==========

    /// <summary>
    /// Bejelentkezett felhasználó fiókjának végleges törlése (jelszó megerősítéssel).
    /// </summary>
    [HttpPost("me/delete")]
    public async Task<IActionResult> DeleteAccount([FromBody] DeleteAccountDto dto)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var user = await _context.users.FindAsync(userId);
        if (user == null)
            return NotFound();

        if (!BCrypt.Net.BCrypt.Verify(dto.Password, user.password))
            return BadRequest(new { message = "Hibás jelszó. A fiók törléséhez add meg a jelenlegi jelszavad." });

        var userReviews = await _context.reviews.Where(r => r.user_id == userId).ToListAsync();
        _context.reviews.RemoveRange(userReviews);
        _context.users.Remove(user);
        await _context.SaveChangesAsync();
        return Ok(new { message = "A fiókod véglegesen törölve lett." });
    }
}
