using Microsoft.EntityFrameworkCore;
using {{APP_NAME}}.Models;

namespace {{APP_NAME}}.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    public DbSet<Item> Items => Set<Item>();
}
