using HouseholdTasksOverview.Model.Repository.cs;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class DifficultyLevelsController : ControllerBase
{
    protected DifficultyLevelsRepository Repository { get; }

    public DifficultyLevelsController(DifficultyLevelsRepository repository)
    {
        Repository = repository;
    }

    [HttpGet]
    public ActionResult GetAll()
    {
        return Ok(Repository.GetAll());
    }
}