using SplitBuddy.Api.Models.Base;

namespace SplitBuddy.Api.Models.Entities
{
    public class User : Entity
    {
        public required string Username { get; set; }
        public required string PasswordHash { get; set; }
        public required string Role { get; set; }

        public required string Email { get; set; }
    }
}
