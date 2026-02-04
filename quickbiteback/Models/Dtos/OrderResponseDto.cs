using System;
using System.Collections.Generic;

namespace quickbiteback.Models.Dtos;

public class OrderListDto
{
    public int Id { get; set; }
    public string Status { get; set; } = null!;
    public string RestaurantName { get; set; } = null!;
    public int Total { get; set; }
    public int ItemCount { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class OrderDetailDto
{
    public int Id { get; set; }
    public string Status { get; set; } = null!;
    public string RestaurantName { get; set; } = null!;
    public int RestaurantId { get; set; }
    public OrderDeliveryDto Delivery { get; set; } = null!;
    public string PaymentMethod { get; set; } = null!;
    public List<OrderItemDto> Items { get; set; } = new();
    public int Subtotal { get; set; }
    public int DeliveryFee { get; set; }
    public int Discount { get; set; }
    public string? CouponCode { get; set; }
    public int Total { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class OrderDeliveryDto
{
    public string FullName { get; set; } = null!;
    public string Address { get; set; } = null!;
    public string City { get; set; } = null!;
    public string Zip { get; set; } = null!;
    public string Phone { get; set; } = null!;
    public string? Instructions { get; set; }
}

public class OrderItemDto
{
    public string Name { get; set; } = null!;
    public int Price { get; set; }
    public int Quantity { get; set; }
    public string? ImageUrl { get; set; }
}
