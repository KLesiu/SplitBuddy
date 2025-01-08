namespace SplitBuddy.Api.Models.Api
{
    public class UserFormVm
    {
        public required int Id { get; set; }
        public required string Username { get; set; }
        public required string Role { get; set; }

        public required string Email { get; set; }
    }
}
