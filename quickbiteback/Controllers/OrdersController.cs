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
public class OrdersController : ControllerBase
{
    private readonly QuickBiteDbContext _context;

    public OrdersController(QuickBiteDbContext context)
    {
        _context = context;
    }

    private int? GetUserId()
    {
        var idStr = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        return int.TryParse(idStr, out var id) ? id : null;
    }

    private static string NormalizePaymentMethod(string method)
    {
        if (string.IsNullOrWhiteSpace(method)) return "cash";
        var m = method.Trim().ToLowerInvariant();
        if (m == "credit-card") return "card";
        if (m == "cash" || m == "card" || m == "szep") return m;
        return "cash";
    }

    /// <summary>
    /// Új rendelés létrehozása.
    /// </summary>
    [HttpPost]
    public async Task<ActionResult<OrderDetailDto>> CreateOrder([FromBody] CreateOrderDto dto)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        if (dto.Items == null || dto.Items.Count == 0)
            return BadRequest(new { message = "A rendelés nem lehet üres." });

        if (dto.Delivery == null ||
            string.IsNullOrWhiteSpace(dto.Delivery.FullName) ||
            string.IsNullOrWhiteSpace(dto.Delivery.Address) ||
            string.IsNullOrWhiteSpace(dto.Delivery.City) ||
            string.IsNullOrWhiteSpace(dto.Delivery.Zip) ||
            string.IsNullOrWhiteSpace(dto.Delivery.Phone))
            return BadRequest(new { message = "Hiányzó szállítási adatok." });

        var restaurantExists = await _context.restaurants.AnyAsync(r => r.id == dto.RestaurantId);
        if (!restaurantExists)
            return BadRequest(new { message = "Érvénytelen étterem." });

        var order = new Order
        {
            user_id = userId.Value,
            restaurant_id = dto.RestaurantId,
            status = "pending",
            delivery_full_name = dto.Delivery.FullName.Trim(),
            delivery_address = dto.Delivery.Address.Trim(),
            delivery_city = dto.Delivery.City.Trim(),
            delivery_zip = dto.Delivery.Zip.Trim(),
            delivery_phone = dto.Delivery.Phone.Trim(),
            delivery_instructions = string.IsNullOrWhiteSpace(dto.Delivery.Instructions) ? null : dto.Delivery.Instructions.Trim(),
            payment_method = NormalizePaymentMethod(dto.PaymentMethod),
            subtotal = dto.Subtotal,
            delivery_fee = dto.DeliveryFee,
            discount = dto.Discount,
            coupon_code = string.IsNullOrWhiteSpace(dto.CouponCode) ? null : dto.CouponCode.Trim(),
            total = dto.Total,
            restaurant_name = dto.RestaurantName.Trim()
        };

        _context.Orders.Add(order);
        await _context.SaveChangesAsync();

        foreach (var item in dto.Items)
        {
            var oi = new OrderItem
            {
                order_id = order.id,
                menu_item_id = item.MenuItemId,
                item_name = item.Name.Trim(),
                item_price = item.Price,
                quantity = item.Quantity,
                item_image_url = string.IsNullOrWhiteSpace(item.ImageUrl) ? null : item.ImageUrl.Trim()
            };
            _context.OrderItems.Add(oi);
        }

        await _context.SaveChangesAsync();

        var savedOrder = await _context.Orders
            .AsNoTracking()
            .Include(o => o.OrderItems)
            .FirstAsync(o => o.id == order.id);
        return CreatedAtAction(nameof(GetOrder), new { id = order.id }, await BuildOrderDetailDtoAsync(savedOrder));
    }

    /// <summary>
    /// Saját rendelések listázása (legújabb először).
    /// </summary>
    [HttpGet]
    public async Task<ActionResult<List<OrderListDto>>> GetMyOrders()
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var orders = await _context.Orders
            .AsNoTracking()
            .Where(o => o.user_id == userId)
            .OrderByDescending(o => o.created_at)
            .Include(o => o.OrderItems)
            .ToListAsync();

        var list = orders.Select(o => new OrderListDto
        {
            Id = o.id,
            Status = o.status,
            RestaurantName = o.restaurant_name,
            Total = o.total,
            ItemCount = o.OrderItems.Sum(i => i.quantity),
            CreatedAt = o.created_at
        }).ToList();

        return Ok(list);
    }

    /// <summary>
    /// Egy rendelés részletes adatainak lekérdezése.
    /// </summary>
    [HttpGet("{id:int}")]
    public async Task<ActionResult<OrderDetailDto>> GetOrder(int id)
    {
        var userId = GetUserId();
        if (userId == null)
            return Unauthorized();

        var order = await _context.Orders
            .AsNoTracking()
            .Include(o => o.OrderItems)
            .FirstOrDefaultAsync(o => o.id == id && o.user_id == userId);

        if (order == null)
            return NotFound();

        return Ok(await BuildOrderDetailDtoAsync(order));
    }

    private static async Task<OrderDetailDto> BuildOrderDetailDtoAsync(Order o)
    {
        await Task.CompletedTask;
        var paymentLabel = o.payment_method switch
        {
            "card" => "Bankkártya",
            "szep" => "SZÉP kártya",
            _ => "Készpénz"
        };

        return new OrderDetailDto
        {
            Id = o.id,
            Status = o.status,
            RestaurantName = o.restaurant_name,
            RestaurantId = o.restaurant_id,
            Delivery = new OrderDeliveryDto
            {
                FullName = o.delivery_full_name,
                Address = o.delivery_address,
                City = o.delivery_city,
                Zip = o.delivery_zip,
                Phone = o.delivery_phone,
                Instructions = o.delivery_instructions
            },
            PaymentMethod = paymentLabel,
            Items = o.OrderItems.Select(i => new OrderItemDto
            {
                Name = i.item_name,
                Price = i.item_price,
                Quantity = i.quantity,
                ImageUrl = i.item_image_url
            }).ToList(),
            Subtotal = o.subtotal,
            DeliveryFee = o.delivery_fee,
            Discount = o.discount,
            CouponCode = o.coupon_code,
            Total = o.total,
            CreatedAt = o.created_at
        };
    }
}
