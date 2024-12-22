using SplitBuddy.Api.Enums;
using SplitBuddy.Api.Models.Base;

namespace SplitBuddy.Api.Models.Entities
{
    public class Payment:Entity
    {
        public required decimal Price { get; set; }
        public required Currency Currency { get; set; }

        public required DateTime DateTime { get; set; }
        public string? Description { get; set; }
        public required User Payer { get; set; }
        public  List<Categories>? Categories { get; set; }
        public required Group Group { get; set; }


    }
}
 