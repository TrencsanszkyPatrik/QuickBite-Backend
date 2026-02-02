using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using quickbiteback.Models;
using quickbiteback.Models.Dtos;

namespace quickbiteback.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuickbiteReviewsController : ControllerBase
    {
        private readonly QuickBiteDbContext _context;

        public QuickbiteReviewsController(QuickBiteDbContext context)
        {
            _context = context;
        }
        
        [HttpGet]
        public async Task<ActionResult<IEnumerable<quickbitereviews>>> GetALlReviws()
        {
            return await _context.quickbitereviews.ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<quickbitereviews>> PostReview(AddNewReviewDto review)
        {
        
            _context.quickbitereviews.Add(new quickbitereviews
            {
                Name = review.Name,
                Username = review.Username,
                Text = review.Review,
                Stars = (sbyte)review.Stars
            });
            await _context.SaveChangesAsync();
            return CreatedAtAction("GetALlReviws", new { }, review);

        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateReview(int id, UpdateReviewDto reviewDto)
        {
            var review = await _context.quickbitereviews.FindAsync(id);
            
            if (review == null)
            {
                return NotFound();
            }

            review.Text = reviewDto.Review;
            review.Stars = (sbyte)reviewDto.Stars;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ReviewExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteReview(int id)
        {
            var review = await _context.quickbitereviews.FindAsync(id);
            if (review == null)
            {
                return NotFound();
            }

            _context.quickbitereviews.Remove(review);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ReviewExists(int id)
        {
            return _context.quickbitereviews.Any(e => e.Id == id);
        }

    }
}