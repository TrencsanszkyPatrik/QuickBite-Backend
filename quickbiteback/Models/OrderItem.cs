using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

[Table("order_items")]
[Index("order_id", Name = "idx_order_items_order_id")]
public partial class OrderItem
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column("order_id", TypeName = "int(11)")]
    public int order_id { get; set; }

    [Column("menu_item_id", TypeName = "int(11)")]
    public int? menu_item_id { get; set; }

    [Column("item_name", TypeName = "text")]
    public string item_name { get; set; } = null!;

    [Column("item_price", TypeName = "int(11)")]
    public int item_price { get; set; }

    [Column("quantity", TypeName = "int(11)")]
    public int quantity { get; set; }

    [Column("item_image_url", TypeName = "text")]
    public string? item_image_url { get; set; }

    [ForeignKey("order_id")]
    [InverseProperty("OrderItems")]
    public virtual Order order { get; set; } = null!;
}
