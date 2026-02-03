using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using quickbiteback.Models;
using quickbiteback.Models.Dtos;
using System.Security.Claims;

namespace quickbiteback.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CouponsController : ControllerBase
    {
        private readonly QuickBiteDbContext _context;

        public CouponsController(QuickBiteDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Összes aktív kupon lekérése
        /// </summary>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CouponDto>>> GetActiveCoupons()
        {
            var now = DateTime.Now;
            var coupons = await _context.Coupons
                .Where(c => c.IsActive && c.ValidFrom <= now && c.ValidUntil >= now)
                .Select(c => new CouponDto
                {
                    Id = c.Id,
                    Code = c.Code,
                    Description = c.Description,
                    DiscountType = c.DiscountType,
                    DiscountValue = c.DiscountValue,
                    MinOrderAmount = c.MinOrderAmount,
                    MaxDiscountAmount = c.MaxDiscountAmount,
                    UsageLimit = c.UsageLimit,
                    UsageCount = c.UsageCount,
                    PerUserLimit = c.PerUserLimit,
                    ValidFrom = c.ValidFrom,
                    ValidUntil = c.ValidUntil,
                    IsActive = c.IsActive,
                    RestaurantId = c.RestaurantId
                })
                .ToListAsync();

            return Ok(coupons);
        }

        /// <summary>
        /// Kuponkód validálása (nincs hozzáadva a felhasználóhoz)
        /// </summary>
        [HttpPost("validate")]
        public async Task<ActionResult<ValidateCouponResponseDto>> ValidateCoupon([FromBody] ValidateCouponRequestDto request)
        {
            var now = DateTime.Now;
            var coupon = await _context.Coupons
                .FirstOrDefaultAsync(c => c.Code.ToUpper() == request.Code.ToUpper() && c.IsActive);

            if (coupon == null)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = "Érvénytelen kuponkód",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Érvényességi idő ellenőrzése
            if (coupon.ValidFrom > now || coupon.ValidUntil < now)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = "Ez a kupon nem érvényes jelenleg",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Minimális rendelési összeg ellenőrzése
            if (coupon.MinOrderAmount.HasValue && request.OrderAmount < coupon.MinOrderAmount.Value)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = $"A minimális rendelési összeg {coupon.MinOrderAmount.Value:N0} Ft",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Használati limit ellenőrzése
            if (coupon.UsageLimit.HasValue && coupon.UsageCount >= coupon.UsageLimit.Value)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = "Ez a kupon már nem használható (elérte a használati limitet)",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Étterem specifikus kupon ellenőrzése
            if (coupon.RestaurantId.HasValue && request.RestaurantId != coupon.RestaurantId.Value)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = "Ez a kupon csak egy meghatározott étteremnél használható",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Kedvezmény számítása
            decimal discountAmount = 0;
            if (coupon.DiscountType == "percentage")
            {
                discountAmount = request.OrderAmount * (coupon.DiscountValue / 100);
                if (coupon.MaxDiscountAmount.HasValue && discountAmount > coupon.MaxDiscountAmount.Value)
                {
                    discountAmount = coupon.MaxDiscountAmount.Value;
                }
            }
            else if (coupon.DiscountType == "fixed_amount")
            {
                discountAmount = coupon.DiscountValue;
            }

            var finalAmount = Math.Max(0, request.OrderAmount - discountAmount);

            return Ok(new ValidateCouponResponseDto
            {
                IsValid = true,
                Message = "Kupon sikeresen alkalmazva!",
                DiscountAmount = discountAmount,
                FinalAmount = finalAmount,
                Coupon = new CouponDto
                {
                    Id = coupon.Id,
                    Code = coupon.Code,
                    Description = coupon.Description,
                    DiscountType = coupon.DiscountType,
                    DiscountValue = coupon.DiscountValue,
                    MinOrderAmount = coupon.MinOrderAmount,
                    MaxDiscountAmount = coupon.MaxDiscountAmount
                }
            });
        }

        /// <summary>
        /// Kupon alkalmazása (felhasználó használja)
        /// </summary>
        [Authorize]
        [HttpPost("apply")]
        public async Task<ActionResult<ValidateCouponResponseDto>> ApplyCoupon([FromBody] ApplyCouponRequestDto request)
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
            {
                return Unauthorized(new { message = "Be kell jelentkezni a kupon használatához" });
            }

            var now = DateTime.Now;
            var coupon = await _context.Coupons
                .FirstOrDefaultAsync(c => c.Code.ToUpper() == request.Code.ToUpper() && c.IsActive);

            if (coupon == null)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = "Érvénytelen kuponkód",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Érvényességi idő ellenőrzése
            if (coupon.ValidFrom > now || coupon.ValidUntil < now)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = "Ez a kupon nem érvényes jelenleg",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Felhasználónkénti limit ellenőrzése
            var userUsageCount = await _context.CouponUsages
                .CountAsync(cu => cu.CouponId == coupon.Id && cu.UserId == userId);

            if (userUsageCount >= coupon.PerUserLimit)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = $"Ezt a kupont már felhasználtad ({coupon.PerUserLimit}x)",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Minimális rendelési összeg ellenőrzése
            if (coupon.MinOrderAmount.HasValue && request.OrderAmount < coupon.MinOrderAmount.Value)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = $"A minimális rendelési összeg {coupon.MinOrderAmount.Value:N0} Ft",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Használati limit ellenőrzése
            if (coupon.UsageLimit.HasValue && coupon.UsageCount >= coupon.UsageLimit.Value)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = "Ez a kupon már nem használható (elérte a használati limitet)",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Étterem specifikus kupon ellenőrzése
            if (coupon.RestaurantId.HasValue && request.RestaurantId != coupon.RestaurantId.Value)
            {
                return Ok(new ValidateCouponResponseDto
                {
                    IsValid = false,
                    Message = "Ez a kupon csak egy meghatározott étteremnél használható",
                    DiscountAmount = 0,
                    FinalAmount = request.OrderAmount
                });
            }

            // Kedvezmény számítása
            decimal discountAmount = 0;
            if (coupon.DiscountType == "percentage")
            {
                discountAmount = request.OrderAmount * (coupon.DiscountValue / 100);
                if (coupon.MaxDiscountAmount.HasValue && discountAmount > coupon.MaxDiscountAmount.Value)
                {
                    discountAmount = coupon.MaxDiscountAmount.Value;
                }
            }
            else if (coupon.DiscountType == "fixed_amount")
            {
                discountAmount = coupon.DiscountValue;
            }

            var finalAmount = Math.Max(0, request.OrderAmount - discountAmount);

            // Kupon használat rögzítése
            var couponUsage = new CouponUsages
            {
                CouponId = coupon.Id,
                UserId = userId,
                OrderId = request.OrderId,
                DiscountAmount = discountAmount,
                UsedAt = DateTime.Now
            };

            _context.CouponUsages.Add(couponUsage);
            
            // Használati számláló növelése
            coupon.UsageCount++;
            _context.Coupons.Update(coupon);

            await _context.SaveChangesAsync();

            return Ok(new ValidateCouponResponseDto
            {
                IsValid = true,
                Message = "Kupon sikeresen alkalmazva!",
                DiscountAmount = discountAmount,
                FinalAmount = finalAmount,
                Coupon = new CouponDto
                {
                    Id = coupon.Id,
                    Code = coupon.Code,
                    Description = coupon.Description,
                    DiscountType = coupon.DiscountType,
                    DiscountValue = coupon.DiscountValue,
                    MinOrderAmount = coupon.MinOrderAmount,
                    MaxDiscountAmount = coupon.MaxDiscountAmount
                }
            });
        }

        /// <summary>
        /// Felhasználó kupon használatai
        /// </summary>
        [Authorize]
        [HttpGet("my-usage")]
        public async Task<ActionResult> GetMyUsage()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
            {
                return Unauthorized(new { message = "Be kell jelentkezni" });
            }

            var usages = await _context.CouponUsages
                .Where(cu => cu.UserId == userId)
                .Include(cu => cu.Coupon)
                .OrderByDescending(cu => cu.UsedAt)
                .Select(cu => new
                {
                    cu.Id,
                    CouponCode = cu.Coupon!.Code,
                    cu.DiscountAmount,
                    cu.UsedAt
                })
                .ToListAsync();

            return Ok(usages);
        }
    }
}
