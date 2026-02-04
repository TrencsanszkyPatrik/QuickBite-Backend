using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using quickbiteback.Models;
using System.Security.Claims;

namespace quickbiteback.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReviewsController : ControllerBase
    {
        private readonly QuickBiteDbContext _context;

        public ReviewsController(QuickBiteDbContext context)
        {
            _context = context;
        }


        [HttpGet("restaurant/{restaurantId}")]
        public async Task<ActionResult<object>> GetRestaurantReviews(int restaurantId)
        {
            var reviews = await _context.reviews
                .Where(r => r.restaurant_id == restaurantId)
                .Include(r => r.user)
                .OrderByDescending(r => r.created_at)
                .Select(r => new
                {
                    r.id,
                    r.rating,
                    r.comment,
                    r.created_at,
                    userName = r.user.name,
                    userEmail = r.user.email
                })
                .ToListAsync();

            var averageRating = reviews.Any() 
                ? Math.Round((double)reviews.Average(r => r.rating) * 2) / 2 // Kerekítés fél csillagra
                : 0;

            var totalReviews = reviews.Count;

            return Ok(new
            {
                averageRating,
                totalReviews,
                reviews
            });
        }

        // GET: api/Reviews/restaurant/{restaurantId}/user-review
        [HttpGet("restaurant/{restaurantId}/user-review")]
        public async Task<ActionResult<object>> GetUserReviewForRestaurant(int restaurantId)
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userIdClaim))
            {
                return Unauthorized(new { message = "Bejelentkezés szükséges" });
            }

            if (!int.TryParse(userIdClaim, out int userId))
            {
                return BadRequest(new { message = "Érvénytelen felhasználó azonosító" });
            }

            var review = await _context.reviews
                .Where(r => r.restaurant_id == restaurantId && r.user_id == userId)
                .Select(r => new
                {
                    r.id,
                    r.rating,
                    r.comment,
                    r.created_at
                })
                .FirstOrDefaultAsync();

            if (review == null)
            {
                return NotFound(new { message = "Nincs értékelés" });
            }

            return Ok(review);
        }

        // POST: api/Reviews
        [HttpPost]
        public async Task<ActionResult<object>> CreateReview([FromBody] CreateReviewDto dto)
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userIdClaim))
            {
                return Unauthorized(new { message = "Bejelentkezés szükséges az értékeléshez" });
            }

            if (!int.TryParse(userIdClaim, out int userId))
            {
                return BadRequest(new { message = "Érvénytelen felhasználó azonosító" });
            }

            if (dto.rating < 0.5m || dto.rating > 5)
            {
                return BadRequest(new { message = "Az értékelésnek 0.5 és 5 között kell lennie" });
            }
            
            // Ellenőrizzük, hogy az értékelés 0.5-ös lépésekben van-e (pl. 1, 1.5, 2, 2.5...)
            if ((dto.rating * 2) % 1 != 0)
            {
                return BadRequest(new { message = "Az értékelés csak 0.5-ös lépésekben adható meg" });
            }

            // Ellenőrizzük, hogy már értékelte-e a felhasználó ezt az éttermet
            var existingReview = await _context.reviews
                .FirstOrDefaultAsync(r => r.restaurant_id == dto.restaurantId && r.user_id == userId);

            if (existingReview != null)
            {
                // Frissítés
                existingReview.rating = dto.rating;
                existingReview.comment = dto.comment;
                existingReview.created_at = DateTime.Now;

                await _context.SaveChangesAsync();

                return Ok(new
                {
                    id = existingReview.id,
                    rating = existingReview.rating,
                    comment = existingReview.comment,
                    created_at = existingReview.created_at,
                    message = "Értékelés frissítve"
                });
            }
            else
            {
                // Új értékelés
                var review = new reviews
                {
                    user_id = userId,
                    restaurant_id = dto.restaurantId,
                    rating = dto.rating,
                    comment = dto.comment,
                    created_at = DateTime.Now
                };

                _context.reviews.Add(review);
                await _context.SaveChangesAsync();

                return CreatedAtAction(nameof(GetRestaurantReviews), new { restaurantId = dto.restaurantId }, new
                {
                    id = review.id,
                    rating = review.rating,
                    comment = review.comment,
                    created_at = review.created_at,
                    message = "Értékelés sikeresen hozzáadva"
                });
            }
        }

        // DELETE: api/Reviews/{id}
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteReview(int id)
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userIdClaim))
            {
                return Unauthorized(new { message = "Bejelentkezés szükséges" });
            }

            if (!int.TryParse(userIdClaim, out int userId))
            {
                return BadRequest(new { message = "Érvénytelen felhasználó azonosító" });
            }

            var review = await _context.reviews.FindAsync(id);
            if (review == null)
            {
                return NotFound(new { message = "Értékelés nem található" });
            }

            if (review.user_id != userId)
            {
                return Forbid();
            }

            _context.reviews.Remove(review);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Értékelés törölve" });
        }
    }

    public class CreateReviewDto
    {
        public int restaurantId { get; set; }
        public decimal rating { get; set; }
        public string? comment { get; set; }
    }
}
