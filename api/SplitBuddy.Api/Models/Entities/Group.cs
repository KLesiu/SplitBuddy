using SplitBuddy.Api.Models.Base;

namespace SplitBuddy.Api.Models.Entities
{
    public class Group:Entity
    {
        public required string Name { get; set; }

        public required DateTime CreatedDate { get; set; }

        public required User Owner { get; set; }
    }
}
