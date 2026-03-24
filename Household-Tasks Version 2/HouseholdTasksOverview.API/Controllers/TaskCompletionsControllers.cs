
using HouseholdTasksOverview.Model.Entities.cs;
using HouseholdTasksOverview.Model.Repository.cs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;

    //SETS THE URL FOR THIS CONTROLLER. [CONTROLLER] BECOMES THIS CLASS NAME.
    //EVERY ENDPOINT IN THIS COTNROLLER LIVES UNDER THAT URL
    [Route("api/[controller]")]
    [ApiController]
    

        
        public class TaskCompletionsController : ControllerBase
    {
        //THIS IS DEPENDCY INJECTION. ASP.NET AUTOMATICALLY CREATES THE REPOSITORY AND HANDS IT TO THE CONTROLLER
        //WE JUST STORE IT IN "Repository" SO ALL OUR METHODS CAN USE IT 
        protected TaskCompletionsRepository Repository { get; }

        public TaskCompletionsController(TaskCompletionsRepository repository)
        {
            Repository = repository;
        }


        //REPONDS TO GET api/taskassigments/id. THE {id} IN THE URL GETS PASSED IN AS THE id PARAMETER.
        [HttpGet("{id}")]
        public ActionResult<TaskCompletions> GetTaskCompletion([FromRoute] int id)
        {
            TaskCompletions completion = Repository.GetTaskCompletionById(id);
            if (completion == null)
            {
                return NotFound($"Task completion with id {id} not found");
            }
            return Ok(completion);
        }



        //RESPONDS TO GET api/taskassignments. RETURNS FULL LIST OF ASSIGMENTS
        [HttpGet]
        public ActionResult<IEnumerable<TaskCompletions>> GetAllTaskCompletions()
        {
            return Ok(Repository.GetAllTaskCompletions());
        }




        //RESPONDS TO POST api/taskassignments. FRONTEND SENDS A JSON OBJECT IN THE REQUEST BODY.
        // ASP.NET CONVERTS IT TO A TaskAssignments OBJECT, AND YOU INSERT IT INTO THE DATABSE
        [HttpPost]
        public ActionResult Post([FromBody] TaskCompletions completion)
        {
            if (completion == null)
            {
                return BadRequest("Task completion info not correct");
            }
            bool status = Repository.InsertTaskCompletion(completion);
            if (status)
            {
                return Ok();
            }
            return BadRequest();
        }


        //RESPONDS TO PUT api/taskassigments. sAME AS POST BUT UPDATES AN EXISTING RECORD
        [HttpPut]
        public ActionResult UpdateTaskCompletion([FromBody] TaskCompletions completion)
        {
            if (completion == null)
            {
                return BadRequest("Task completion info not correct");
            }
            TaskCompletions existing = Repository.GetTaskCompletionById(completion.Id);
            if (existing == null)
            {
                return NotFound($"Task completion with id {completion.Id} not found");
            }
            bool status = Repository.UpdateTaskCompletion(completion);
            if (status)
            {
                return Ok();
            }
            return BadRequest("Something went wrong");
        }



        //REPONDS TO DELETE api/taskassignments/id.
        [HttpDelete("{id}")]
        public ActionResult DeleteTaskCompletion([FromRoute] int id)
        {
            TaskCompletions existing = Repository.GetTaskCompletionById(id);
            if (existing == null)
            {
                return NotFound($"Task completion with id {id} not found");
            }
            bool status = Repository.DeleteTaskCompletion(id);
            if (status)
            {
                return NoContent();
            }
            return BadRequest($"Unable to delete task completion with id {id}");
        }
    }


