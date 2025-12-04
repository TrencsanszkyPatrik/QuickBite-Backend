using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using quickbiteback.Models;

namespace quickbiteback.Controllers
{
    

    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly QuickBiteDbContext _context;

        public CategoriesController(QuickBiteDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<categories>>> GetCategories()
        {
            return await _context.categories.ToListAsync();
        }

    }
}
