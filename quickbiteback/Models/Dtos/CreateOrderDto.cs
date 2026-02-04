using System.Collections.Generic;

namespace quickbiteback.Models.Dtos;

public class CreateOrderDto
{
    public List<CreateOrderItemDto> Items { get; set; } = new();
    public CreateOrderDeliveryDto Delivery { get; set; } = null!;
    public string PaymentMethod { get; set; } = null!;
    public int? SavedAddressId { get; set; }
    public int? SavedPaymentId { get; set; }
    public int Subtotal { get; set; }
    public int DeliveryFee { get; set; }
    public int Discount { get; set; }
    public string? CouponCode { get; set; }
    public int Total { get; set; }
    public int RestaurantId { get; set; }
    public string RestaurantName { get; set; } = null!;
}

public class CreateOrderItemDto
{
    public int? MenuItemId { get; set; }
    public string Name { get; set; } = null!;
    public int Price { get; set; }
    public int Quantity { get; set; }
    public string? ImageUrl { get; set; }
}

public class CreateOrderDeliveryDto
{
    public string FullName { get; set; } = null!;
    public string Address { get; set; } = null!;
    public string City { get; set; } = null!;
    public string Zip { get; set; } = null!;
    public string Phone { get; set; } = null!;
    public string? Instructions { get; set; }
}
