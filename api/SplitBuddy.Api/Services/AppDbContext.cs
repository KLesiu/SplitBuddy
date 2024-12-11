using Microsoft.EntityFrameworkCore;
using SplitBuddy.Api.Models.Entities;

namespace SplitBuddy.Api.Services
{
    public class AppDbContext : DbContext
    {
        public required DbSet<User> Users { get; set; }

        public required DbSet<Group> Groups { get; set; }

        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }
    }
}
