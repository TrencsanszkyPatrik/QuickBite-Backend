using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using quickbiteback.Models;

namespace quickbiteback.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RestaurantsController : ControllerBase
    {
        private readonly QuickBiteDbContext _context;

        public RestaurantsController(QuickBiteDbContext context)
        {
            _context = context;
        }

        // GET: api/Restaurants
        [HttpGet]
        public async Task<ActionResult<IEnumerable<restaurants>>> GetRestaurants()
        {
            return await _context.restaurants.ToListAsync();
        }

        // GET: api/Restaurants/5
        [HttpGet("{id}")]
        public async Task<ActionResult<restaurants>> GetRestaurants(int id)
        {
            var restaurants = await _context.restaurants.FindAsync(id);
            if (restaurants == null)
            {
                return NotFound();
            }
            return restaurants;
        }

        // PUT: api/Restaurants/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRestaurants(int id, restaurants restaurants)
        {
            if (id != restaurants.id)
            {
                return BadRequest();
            }

            _context.Entry(restaurants).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RestaurantsExists(id))
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

        // POST: api/Restaurants
        [HttpPost]
        public async Task<ActionResult<restaurants>> PostRestaurants(restaurants restaurants)
        {
            _context.restaurants.Add(restaurants);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetRestaurants), new { id = restaurants.id }, restaurants);
        }

        // DELETE: api/Restaurants/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRestaurants(int id)
        {
            var restaurants = await _context.restaurants.FindAsync(id);
            if (restaurants == null)
            {
                return NotFound();
            }

            _context.restaurants.Remove(restaurants);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RestaurantsExists(int id)
        {
            return _context.restaurants.Any(e => e.id == id);
        }
    }
}