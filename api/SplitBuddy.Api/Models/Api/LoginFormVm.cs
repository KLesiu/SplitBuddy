using System.ComponentModel.DataAnnotations;

namespace SplitBuddy.Api.Models.Api
{
    public class LoginFormVm
    {
        [Required(ErrorMessage = "Username is required.")]
        public required string Username {  get; set; }

        [Required(ErrorMessage = "Password is required.")]
        public required string Password { get; set; }
    }
}
