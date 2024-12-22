using SplitBuddy.Api.Models.Base;

namespace SplitBuddy.Api.Models.Entities
{
    public class GroupMembership:Entity
    {
        public required User User { get; set; }
        public required Group Group { get; set; }
    }
}
