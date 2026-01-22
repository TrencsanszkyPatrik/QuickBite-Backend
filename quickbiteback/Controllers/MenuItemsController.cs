using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using quickbiteback.Models;

namespace quickbiteback.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MenuItemsController : ControllerBase
    {
        private readonly QuickBiteDbContext _context;

        public MenuItemsController(QuickBiteDbContext context)
        {
            _context = context;
        }

        // GET: api/MenuItems
        [HttpGet]
        public async Task<ActionResult<IEnumerable<menu_items>>> GetMenuItems()
        {
            return await _context.menu_items
                .Where(m => m.is_available)
                .ToListAsync();
        }

        // GET: api/MenuItems/restaurant/5
        [HttpGet("restaurant/{restaurantId}")]
        public async Task<ActionResult<IEnumerable<menu_items>>> GetMenuItemsByRestaurant(int restaurantId)
        {
            var menuItems = await _context.menu_items
                .Where(m => m.restaurant_id == restaurantId && m.is_available)
                .OrderBy(m => m.category)
                .ThenBy(m => m.name)
                .ToListAsync();

            return menuItems;
        }

        // GET: api/MenuItems/5
        [HttpGet("{id}")]
        public async Task<ActionResult<menu_items>> GetMenuItem(int id)
        {
            var menuItem = await _context.menu_items.FindAsync(id);

            if (menuItem == null)
            {
                return NotFound();
            }

            return menuItem;
        }

        // POST: api/MenuItems
        [HttpPost]
        public async Task<ActionResult<menu_items>> PostMenuItem(menu_items menuItem)
        {
            _context.menu_items.Add(menuItem);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetMenuItem), new { id = menuItem.id }, menuItem);
        }

        // PUT: api/MenuItems/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMenuItem(int id, menu_items menuItem)
        {
            if (id != menuItem.id)
            {
                return BadRequest();
            }

            _context.Entry(menuItem).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MenuItemExists(id))
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

        // DELETE: api/MenuItems/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMenuItem(int id)
        {
            var menuItem = await _context.menu_items.FindAsync(id);
            if (menuItem == null)
            {
                return NotFound();
            }

            _context.menu_items.Remove(menuItem);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool MenuItemExists(int id)
        {
            return _context.menu_items.Any(e => e.id == id);
        }
    }
}

