using SplitBuddy.Api.Models.Base;

namespace SplitBuddy.Api.Models.Entities
{
    public class PaymentSplits:Entity
    {
        public required decimal Cost { get; set; }
        public required Payment Payment { get; set; }
        public required User Debtor { get; set; }
        public required decimal PercentageCost { get; set; }
        
    }
}
