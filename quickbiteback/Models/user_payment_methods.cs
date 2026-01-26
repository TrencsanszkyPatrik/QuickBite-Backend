using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

[Table("user_payment_methods")]
[Index("user_id", Name = "idx_user_payment_methods_user_id")]
public partial class user_payment_methods
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column("user_id", TypeName = "int(11)")]
    public int user_id { get; set; }

    /// <summary>card, cash, szep</summary>
    [Column(TypeName = "varchar(20)")]
    [MaxLength(20)]
    public string type { get; set; } = null!;

    [Column("display_name", TypeName = "varchar(100)")]
    [MaxLength(100)]
    public string display_name { get; set; } = null!;

    [Column("last_four_digits", TypeName = "varchar(4)")]
    [MaxLength(4)]
    public string? last_four_digits { get; set; }

    [Column("is_default", TypeName = "tinyint(1)")]
    public bool is_default { get; set; }

    [ForeignKey("user_id")]
    [InverseProperty("user_payment_methods")]
    public virtual users user { get; set; } = null!;
}
