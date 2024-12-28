namespace SplitBuddy.Api.Models.Api
{
    public class GroupMembershipFormVm
    {
        public required int? Id { get; set; }
        public required UserFormVm User { get; set; }
        public required GroupFormVm Group { get; set; }
    }
}
