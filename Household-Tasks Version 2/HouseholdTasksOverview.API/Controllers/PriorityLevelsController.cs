using HouseholdTasksOverview.Model.Repository.cs;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class PriorityLevelsController : ControllerBase
{
    protected PriorityLevelsRepository Repository { get; }

    public PriorityLevelsController(PriorityLevelsRepository repository)
    {
        Repository = repository;
    }

    [HttpGet]
    public ActionResult GetAll()
    {
        return Ok(Repository.GetAll());
    }
}