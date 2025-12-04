using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

public partial class categories
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column(TypeName = "text")]
    public string name { get; set; } = null!;

    [Column(TypeName = "text")]
    public string icon { get; set; } = null!;

    [InverseProperty("cuisine")]
    public virtual ICollection<restaurants> restaurants { get; set; } = new List<restaurants>();
}
