using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace quickbiteback.Models
{
    [Table("coupons")]
    public class Coupons
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("code")]
        [MaxLength(50)]
        public string Code { get; set; } = string.Empty;

        [Column("description")]
        public string? Description { get; set; }

        [Required]
        [Column("discount_type")]
        [MaxLength(20)]
        public string DiscountType { get; set; } = string.Empty; // "percentage" vagy "fixed_amount"

        [Required]
        [Column("discount_value")]
        public decimal DiscountValue { get; set; }

        [Column("min_order_amount")]
        public decimal? MinOrderAmount { get; set; }

        [Column("max_discount_amount")]
        public decimal? MaxDiscountAmount { get; set; }

        [Column("usage_limit")]
        public int? UsageLimit { get; set; }

        [Column("usage_count")]
        public int UsageCount { get; set; } = 0;

        [Column("per_user_limit")]
        public int PerUserLimit { get; set; } = 1;

        [Required]
        [Column("valid_from")]
        public DateTime ValidFrom { get; set; }

        [Required]
        [Column("valid_until")]
        public DateTime ValidUntil { get; set; }

        [Column("is_active")]
        public bool IsActive { get; set; } = true;

        [Column("restaurant_id")]
        public int? RestaurantId { get; set; }

        [Column("created_at")]
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        // Navigation properties
        [ForeignKey("RestaurantId")]
        public virtual restaurants? Restaurant { get; set; }

        public virtual ICollection<CouponUsages> CouponUsages { get; set; } = new List<CouponUsages>();
    }
}
