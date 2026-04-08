using Microsoft.AspNetCore.Mvc;

namespace {{APP_NAME}}.Controllers;

[ApiController]
public class HealthController : ControllerBase
{
    [HttpGet("health")]
    public IActionResult Health() => Ok(new { status = "ok" });
}
