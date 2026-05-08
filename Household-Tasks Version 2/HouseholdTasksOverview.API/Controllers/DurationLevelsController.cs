using HouseholdTasksOverview.Model.Repository.cs;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class DurationLevelsController : ControllerBase
{
    protected DurationLevelsRepository Repository { get; }

    public DurationLevelsController(DurationLevelsRepository repository)
    {
        Repository = repository;
    }

    [HttpGet]
    public ActionResult GetAll()
    {
        return Ok(Repository.GetAll());
    }
}