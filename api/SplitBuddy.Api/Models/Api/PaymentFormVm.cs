using SplitBuddy.Api.Enums;

namespace SplitBuddy.Api.Models.Api
{
    public class PaymentFormVm
    {

        public int? Id { get; set; }
        public required decimal Price { get; set; }
        public required Currency Currency { get; set; }

        public required DateTime DateTime { get; set; }
        public string? Description { get; set; }
        public required UserFormVm Payer { get; set; }
        public List<Categories>? Categories { get; set; }
        public required GroupFormVm Group { get; set; }
    }
}
