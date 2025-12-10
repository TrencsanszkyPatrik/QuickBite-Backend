using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using quickbiteback.Models;

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

    }
}