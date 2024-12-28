namespace SplitBuddy.Api.Models.Api
{
    public class PaymentSplitsFormVm
    {
        public int? Id { get; set; }
        public required PaymentFormVm Payment {  get; set; }
        public required UserFormVm Debtor { get; set; }
        public required decimal PercentageCost { get; set; }
        public required decimal Cost { get; set; }

    }
}
