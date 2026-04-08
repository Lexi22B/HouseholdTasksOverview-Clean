using HouseholdTasksOverview.Model.Entities.cs;
using HouseholdTasksOverview.Model.Repository.cs;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class TasksController : ControllerBase
{
    protected TasksRepository Repository { get; }

    public TasksController(TasksRepository repository)
    {
        Repository = repository;
    }

    [HttpGet("{id}")]
    public ActionResult<Tasks> GetTask([FromRoute] int id)
    {
        Tasks task = Repository.GetTaskById(id);
        if (task == null)
        {
            return NotFound($"Task with id {id} not found");
        }
        return Ok(task);
    }

    [HttpGet]
    public ActionResult<IEnumerable<Tasks>> GetAllTasks()
    {
        return Ok(Repository.GetAllTasks());
    }

    [HttpPost]
    public ActionResult Post([FromBody] Tasks task)
    {
        if (task == null)
        {
            return BadRequest("Task info not correct");
        }
        bool status = Repository.InsertTask(task);
        if (status)
        {
            return Ok();
        }
        return BadRequest("Failed to create task");
    }

    [HttpPut]
    public ActionResult UpdateTask([FromBody] Tasks task)
    {
        if (task == null)
        {
            return BadRequest("Task info not correct");
        }
        Tasks existingTask = Repository.GetTaskById(task.Id);
        if (existingTask == null)
        {
            return NotFound($"Task with id {task.Id} not found");
        }
        bool status = Repository.UpdateTask(task);
        if (status)
        {
            return Ok();
        }
        return BadRequest("Something went wrong");
    }

    [HttpDelete("{id}")]
    public ActionResult DeleteTask([FromRoute] int id)
    {
        Tasks existingTask = Repository.GetTaskById(id);
        if (existingTask == null)
        {
            return NotFound($"Task with id {id} not found");
        }
        bool status = Repository.DeleteTask(id);
        if (status)
        {
            return NoContent();
        }
        return BadRequest($"Unable to delete task with id {id}");
    }
}
