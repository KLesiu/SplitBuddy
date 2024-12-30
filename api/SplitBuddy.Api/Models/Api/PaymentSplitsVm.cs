namespace SplitBuddy.Api.Models.Api
{
    public class PaymentSplitsVm
    {
        public int? Id { get; set; }
        public required decimal Cost { get; set; }
        public required int DebtorId { get; set; }
        public required decimal PercentageCost { get; set; }

    }
}
