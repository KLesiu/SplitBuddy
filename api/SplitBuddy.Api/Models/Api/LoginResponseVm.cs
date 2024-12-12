namespace SplitBuddy.Api.Models.Api
{
    public class LoginResponseVm
    {
        public string? UserName { get; set; }
        public string? AccessToken {  get; set; }
        public int ExpiresIn {  get; set; }
    }
}
