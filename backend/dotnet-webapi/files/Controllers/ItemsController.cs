using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using {{APP_NAME}}.Data;
using {{APP_NAME}}.Models;

namespace {{APP_NAME}}.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ItemsController : ControllerBase
{
    private readonly AppDbContext _db;

    public ItemsController(AppDbContext db) => _db = db;

    [HttpGet]
    public async Task<ActionResult<List<Item>>> GetItems()
    {
        return await _db.Items.ToListAsync();
    }

    [HttpPost]
    public async Task<ActionResult<Item>> CreateItem(Item item)
    {
        _db.Items.Add(item);
        await _db.SaveChangesAsync();
        return CreatedAtAction(nameof(GetItems), new { id = item.Id }, item);
    }
}
