namespace SplitBuddy.Api.Models.Entities
{
    public class Group
    {
        public int? Id { get; set; }

        public required string Name { get; set; }

        public required DateTime CreatedDate { get; set; }

        public required User Owner { get; set; }
    }
}
