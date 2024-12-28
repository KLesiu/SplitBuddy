
using SplitBuddy.Api.Enums;

namespace SplitBuddy.Api.Models.Api
{
    public class PaymentVm
    {
        public required List<PaymentSplitsVm> PaymentSplits { get; set; }
        public int? Id { get; set; }
        public required decimal Price { get; set; }
        public required Currency Currency { get; set; }

        public required DateTime DateTime { get; set; }
        public string? Description { get; set; }
        public required int PayerId { get; set; }
        public List<Categories>? Categories { get; set; }
        public required int GroupId { get; set; }
    }
}
