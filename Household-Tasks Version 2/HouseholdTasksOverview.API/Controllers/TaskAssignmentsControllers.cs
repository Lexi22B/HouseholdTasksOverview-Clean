
using HouseholdTasksOverview.Model.Entities.cs;
using HouseholdTasksOverview.Model.Repository.cs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;

    //SETS THE URL FOR THIS CONTROLLER. [CONTROLLER] BECOMES THIS CLASS NAME.
    //EVERY ENDPOINT IN THIS COTNROLLER LIVES UNDER THAT URL
    [Route("api/[controller]")]
    [ApiController]


    
    public class TaskAssignmentsController : ControllerBase
{
    //THIS IS DEPENDCY INJECTION. ASP.NET AUTOMATICALLY CREATES THE REPOSITORY AND HANDS IT TO THE CONTROLLER
    //WE JUST STORE IT IN "Repository" SO ALL OUR METHODS CAN USE IT 
    protected TaskAssignmentsRepository Repository { get; }

    public TaskAssignmentsController(TaskAssignmentsRepository repository)
    {
        Repository = repository;
    }


    //REPONDS TO GET api/taskassigments/id. THE {id} IN THE URL GETS PASSED IN AS THE id PARAMETER.
    [HttpGet("{id}")]
    public ActionResult<TaskAssignments> GetTaskAssignment([FromRoute] int id)
    {
        TaskAssignments assignment = Repository.GetTaskAssignmentById(id);
        if (assignment == null)
        {
            return NotFound($"Task assignment with id {id} not found");
        }
        return Ok(assignment);
    }


    //RESPONDS TO GET api/taskassignments. RETURNS FULL LIST OF ASSIGMENTS
    [HttpGet]
    public ActionResult<IEnumerable<TaskAssignments>> GetAllTaskAssignments()
    {
        return Ok(Repository.GetAllTaskAssignments());
    }


    //RESPONDS TO POST api/taskassignments. FRONTEND SENDS A JSON OBJECT IN THE REQUEST BODY.
    // ASP.NET CONVERTS IT TO A TaskAssignments OBJECT, AND YOU INSERT IT INTO THE DATABSE
    [HttpPost]
    public ActionResult Post([FromBody] TaskAssignments assignment)
    {
        if (assignment == null)
        {
            return BadRequest("Task assignment info not correct");
        }
        bool status = Repository.InsertTaskAssignment(assignment);
        if (status)
        {
            return Ok();
        }
        return BadRequest();
    }



    //RESPONDS TO PUT api/taskassigments. sAME AS POST BUT UPDATES AN EXISTING RECORD
    [HttpPut]
    public ActionResult UpdateTaskAssignment([FromBody] TaskAssignments assignment)
    {
        if (assignment == null)
        {
            return BadRequest("Task assignment info not correct");
        }
        TaskAssignments existing = Repository.GetTaskAssignmentById(assignment.Id);
        if (existing == null)
        {
            return NotFound($"Task assignment with id {assignment.Id} not found");
        }
        bool status = Repository.UpdateTaskAssignment(assignment);
        if (status)
        {
            return Ok();
        }
        return BadRequest("Something went wrong");
    }


    //REPONDS TO DELETE api/taskassignments/id.
    [HttpDelete("{id}")]
    public ActionResult DeleteTaskAssignment([FromRoute] int id)
    {
        TaskAssignments existing = Repository.GetTaskAssignmentById(id);
        if (existing == null)
        {
            return NotFound($"Task assignment with id {id} not found");
        }
        bool status = Repository.DeleteTaskAssignment(id);
        if (status)
        {
            return NoContent();
        }
        return BadRequest($"Unable to delete task assignment with id {id}");
    }
}

