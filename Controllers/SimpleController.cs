using Microsoft.AspNetCore.Mvc;

[Route("api/[controller]")]
[ApiController]
public class SimpleController : ControllerBase
{
    [HttpGet("play")]
    public IActionResult Play()
    {
        return Content("Play=True", "text/html");
    }
}