using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace quickbiteback.Models;

[Table("user_addresses")]
[Index("user_id", Name = "idx_user_addresses_user_id")]
public partial class user_addresses
{
    [Key]
    [Column(TypeName = "int(11)")]
    public int id { get; set; }

    [Column("user_id", TypeName = "int(11)")]
    public int user_id { get; set; }

    [Column(TypeName = "varchar(50)")]
    [MaxLength(50)]
    public string label { get; set; } = null!;

    [Column("address_line", TypeName = "text")]
    public string address_line { get; set; } = null!;

    [Column(TypeName = "varchar(100)")]
    [MaxLength(100)]
    public string city { get; set; } = null!;

    [Column("zip_code", TypeName = "varchar(10)")]
    [MaxLength(10)]
    public string zip_code { get; set; } = null!;

    [Column("is_default", TypeName = "tinyint(1)")]
    public bool is_default { get; set; }

    [ForeignKey("user_id")]
    [InverseProperty("user_addresses")]
    public virtual users user { get; set; } = null!;
}
