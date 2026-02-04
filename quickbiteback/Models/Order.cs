using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

[Table("orders")]
[Index("user_id", Name = "idx_orders_user_id")]
[Index("restaurant_id", Name = "idx_orders_restaurant_id")]
public partial class Order
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column("user_id", TypeName = "int(11)")]
    public int user_id { get; set; }

    [Column("restaurant_id", TypeName = "int(11)")]
    public int restaurant_id { get; set; }

    [Column(TypeName = "varchar(50)")]
    [MaxLength(50)]
    public string status { get; set; } = "pending";

    [Column("delivery_full_name", TypeName = "text")]
    public string delivery_full_name { get; set; } = null!;

    [Column("delivery_address", TypeName = "text")]
    public string delivery_address { get; set; } = null!;

    [Column("delivery_city", TypeName = "varchar(100)")]
    [MaxLength(100)]
    public string delivery_city { get; set; } = null!;

    [Column("delivery_zip", TypeName = "varchar(10)")]
    [MaxLength(10)]
    public string delivery_zip { get; set; } = null!;

    [Column("delivery_phone", TypeName = "varchar(30)")]
    [MaxLength(30)]
    public string delivery_phone { get; set; } = null!;

    [Column("delivery_instructions", TypeName = "text")]
    public string? delivery_instructions { get; set; }

    [Column("payment_method", TypeName = "varchar(50)")]
    [MaxLength(50)]
    public string payment_method { get; set; } = null!;

    [Column("subtotal", TypeName = "int(11)")]
    public int subtotal { get; set; }

    [Column("delivery_fee", TypeName = "int(11)")]
    public int delivery_fee { get; set; }

    [Column("discount", TypeName = "int(11)")]
    public int discount { get; set; }

    [Column("coupon_code", TypeName = "varchar(50)")]
    [MaxLength(50)]
    public string? coupon_code { get; set; }

    [Column("total", TypeName = "int(11)")]
    public int total { get; set; }

    [Column("restaurant_name", TypeName = "text")]
    public string restaurant_name { get; set; } = null!;

    [Column("created_at", TypeName = "datetime")]
    public DateTime created_at { get; set; }

    [ForeignKey("restaurant_id")]
    [InverseProperty("Orders")]
    public virtual restaurants restaurant { get; set; } = null!;

    [ForeignKey("user_id")]
    [InverseProperty("Orders")]
    public virtual users user { get; set; } = null!;

    [InverseProperty("order")]
    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
}
