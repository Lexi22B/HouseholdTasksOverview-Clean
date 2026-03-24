
using HouseholdTasksOverview.Model.Entities;
using HouseholdTasksOverview.Model.Entities.cs;
using HouseholdTasksOverview.Model.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;
{
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
        public ActionResult<TaskItem> GetTask([FromRoute] int id)
        {
            TaskItem taskItem= Repository.GetStudentById(id);
            if (taskItem == null)
            {
                return NotFound();
            }
            return Ok(taskItem);
        }

        [HttpGet]
        public ActionResult<IEnumerable<TaskItem>> GetTasks()
        {
            return Ok(Repository.GetStudents());
        }

        [HttpPost]
        public ActionResult Post([FromBody] TaskItem taskItem)
        {
            if (taskItem == null)
            {
                return BadRequest("Task info not correct");
            }
            bool status = Repository.InsertTask(taskItem);

            if (status)
            {
                return Ok();
            }
            return BadRequest("Failed to create the task in the database."); //choose a message
        }

        [HttpPut]

        public ActionResult UpdateTask([FromBody] TaskItem taskItem)
        {
            if (taskItem == null)
            {
                return BadRequest("Task info not correct");
            }
            TaskItem existinTask = Repository.GetStudentById(student.Id);
            if (existinTask == null)
            {
                return NotFound($"Task with id {taskItem.Id} not found");
            }
            bool status = Repository.UpdateStudent(taskItem);
            if (status)
            {
                return Ok();
            }
            return BadRequest("Something went wrong");
        }
        [HttpDelete("{id}")]
        public ActionResult DeleteTask([FromRoute] int id)
        {
            TaskItem existingTask  = Repository.GetStudentById(id);
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
}

