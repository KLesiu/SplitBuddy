using SplitBuddy.Api.Models.Base;

namespace SplitBuddy.Api.Models.Entities
{
    public class Friendship : Entity
    {
        public required User User { get; set; }
        public required User Friend { get; set; }
    }
}
