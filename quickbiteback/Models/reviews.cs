using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

[Index("restaurant_id", Name = "fk_reviews_restaurant")]
[Index("user_id", Name = "fk_reviews_user")]
public partial class reviews
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column(TypeName = "int(11)")]
    public int user_id { get; set; }

    [Column(TypeName = "int(11)")]
    public int restaurant_id { get; set; }

    [Column(TypeName = "tinyint(4)")]
    public sbyte rating { get; set; }

    [Column(TypeName = "text")]
    public string? comment { get; set; }

    [Column(TypeName = "timestamp")]
    public DateTime created_at { get; set; }

    [ForeignKey("restaurant_id")]
    [InverseProperty("reviews")]
    public virtual restaurants restaurant { get; set; } = null!;

    [ForeignKey("user_id")]
    [InverseProperty("reviews")]
    public virtual users user { get; set; } = null!;
}
