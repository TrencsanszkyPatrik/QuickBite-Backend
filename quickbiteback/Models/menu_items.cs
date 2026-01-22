using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

[Index("restaurant_id", Name = "fk_menu_items_restaurant")]
public partial class menu_items
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column(TypeName = "int(11)")]
    public int restaurant_id { get; set; }

    [Column(TypeName = "text")]
    public string name { get; set; } = null!;

    [Column(TypeName = "text")]
    public string? description { get; set; }

    [Column(TypeName = "int(11)")]
    public int price { get; set; }

    [Column(TypeName = "text")]
    public string? image_url { get; set; }

    [Column(TypeName = "text")]
    public string? category { get; set; }

    [Column(TypeName = "tinyint(1)")]
    public bool is_available { get; set; } = true;

    [Column(TypeName = "datetime")]
    public DateTime created_at { get; set; }

    [ForeignKey("restaurant_id")]
    [InverseProperty("menu_items")]
    public virtual restaurants restaurant { get; set; } = null!;
}

