using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace quickbiteback.Models
{
    [Table("coupon_usages")]
    public class CouponUsages
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("coupon_id")]
        public int CouponId { get; set; }

        [Required]
        [Column("user_id")]
        public int UserId { get; set; }

        [Column("order_id")]
        public int? OrderId { get; set; }

        [Required]
        [Column("discount_amount")]
        public decimal DiscountAmount { get; set; }

        [Column("used_at")]
        public DateTime UsedAt { get; set; } = DateTime.Now;

        // Navigation properties
        [ForeignKey("CouponId")]
        public virtual Coupons? Coupon { get; set; }

        [ForeignKey("UserId")]
        public virtual users? User { get; set; }
    }
}
