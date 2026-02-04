using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

[Index("cuisine_id", Name = "fk_restaurants_category")]
public partial class restaurants
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column(TypeName = "text")]
    public string name { get; set; } = null!;

    [Column(TypeName = "text")]
    public string address { get; set; } = null!;

    [Column(TypeName = "text")]
    public string city { get; set; } = null!;

    [Column(TypeName = "text")]
    public string description { get; set; } = null!;

    [Column(TypeName = "text")]
    public string description_long { get; set; } = null!;

    [Column(TypeName = "text")]
    public string image_url { get; set; } = null!;

    [Column(TypeName = "int(11)")]
    public int discount { get; set; }

    public bool free_delivery { get; set; }

    public bool accept_cards { get; set; }

    [Column(TypeName = "int(11)")]
    public int cuisine_id { get; set; }

    [Precision(10, 0)]
    public decimal latitude { get; set; }

    [Precision(10, 0)]
    public decimal longitude { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime created_at { get; set; }

    public string phonenumber { get; set; }

    [ForeignKey("cuisine_id")]
    [InverseProperty("restaurants")]
    public virtual categories cuisine { get; set; } = null!;

    [InverseProperty("restaurant")]
    public virtual ICollection<reviews> reviews { get; set; } = new List<reviews>();

    [InverseProperty("restaurant")]
    public virtual ICollection<menu_items> menu_items { get; set; } = new List<menu_items>();

    [InverseProperty("restaurant")]
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
