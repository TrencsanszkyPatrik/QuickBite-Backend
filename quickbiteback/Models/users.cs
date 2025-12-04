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

    [InverseProperty("user")]
    public virtual ICollection<reviews> reviews { get; set; } = new List<reviews>();
}
