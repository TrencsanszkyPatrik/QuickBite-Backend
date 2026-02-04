using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

[Index("email", Name = "email", IsUnique = true)]
public partial class users
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column(TypeName = "text")]
    public string name { get; set; } = null!;

    [Column(TypeName = "text")]
    public string email { get; set; } = null!;

    [Column(TypeName = "text")]
    public string password { get; set; } = null!;

    [Column(TypeName = "date")]
    public DateTime created_at { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? updated_at { get; set; }

    [Column(TypeName = "varchar(30)")]
    [MaxLength(30)]
    public string? phone { get; set; }

    [Column(TypeName = "text")]
    public string? avatar_url { get; set; }

    [Column("address_line", TypeName = "text")]
    public string? address_line { get; set; }

    [Column(TypeName = "varchar(100)")]
    [MaxLength(100)]
    public string? city { get; set; }

    [Column("zip_code", TypeName = "varchar(10)")]
    [MaxLength(10)]
    public string? zip_code { get; set; }

    [InverseProperty("user")]
    public virtual ICollection<reviews> reviews { get; set; } = new List<reviews>();

    [InverseProperty("user")]
    public virtual ICollection<user_addresses> user_addresses { get; set; } = new List<user_addresses>();

    [InverseProperty("user")]
    public virtual ICollection<user_payment_methods> user_payment_methods { get; set; } = new List<user_payment_methods>();

    [InverseProperty("user")]
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
