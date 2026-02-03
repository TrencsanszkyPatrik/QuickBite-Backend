using System.ComponentModel.DataAnnotations;

namespace quickbiteback.Models.Dtos
{
    public class ValidateCouponRequestDto
    {
        [Required(ErrorMessage = "A kuponkód megadása kötelező")]
        public string Code { get; set; } = string.Empty;

        [Required(ErrorMessage = "A rendelési összeg megadása kötelező")]
        [Range(0, double.MaxValue, ErrorMessage = "A rendelési összeg nem lehet negatív")]
        public decimal OrderAmount { get; set; }

        public int? RestaurantId { get; set; }
    }

    public class ValidateCouponResponseDto
    {
        public bool IsValid { get; set; }
        public string Message { get; set; } = string.Empty;
        public decimal DiscountAmount { get; set; }
        public decimal FinalAmount { get; set; }
        public CouponDto? Coupon { get; set; }
    }

    public class ApplyCouponRequestDto
    {
        [Required(ErrorMessage = "A kuponkód megadása kötelező")]
        public string Code { get; set; } = string.Empty;

        [Required(ErrorMessage = "A rendelési összeg megadása kötelező")]
        public decimal OrderAmount { get; set; }

        public int? RestaurantId { get; set; }
        public int? OrderId { get; set; }
    }
}
