using Microsoft.EntityFrameworkCore;
using SplitBuddy.Api.Models.Entities;

namespace SplitBuddy.Api.Services
{
    public class AppDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }

        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }
    }
}
