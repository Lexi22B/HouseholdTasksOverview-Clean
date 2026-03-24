

using HouseholdTasksOverview.Model.Entities.cs;

using HouseholdTasksOverview.Model.Repository.cs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;

     public class HousematesController : ControllerBase
    {
        protected HousematesRepository Repository { get; }

        public HousematesController(HousematesRepository repository)
        {
            Repository = repository;
        }

        [HttpGet("{id}")]
        public ActionResult<Housemates> GetHousemate([FromRoute] int id)
        {
            Housemates housemate = Repository.GetHousemateById(id);

            if (housemate == null)
            {
                return NotFound($"Housemate with id {id} not found");
            }

            return Ok(housemate);
        }

        [HttpGet]
        public ActionResult<IEnumerable<Housemates>> GetAllHousemates()
        {
            return Ok(Repository.GetHousemates());
        }

        [HttpPost]
        public ActionResult Post([FromBody] Housemates housemate)
        {
            if (housemate == null)
            {
                return BadRequest("Housemate info not correct");
            }

            bool status = Repository.InsertHousemate(housemate);

            if (status)
            {
                return Ok();
            }

            return BadRequest("Unable to insert housemate");
        }

        [HttpPut]
        public ActionResult UpdateHousemate([FromBody] Housemates housemate)
        {
            if (housemate == null)
            {
                return BadRequest("Housemate info not correct");
            }

            Housemates existing = Repository.GetHousemateById(housemate.Id);

            if (existing == null)
            {
                return NotFound($"Housemate with id {housemate.Id} not found");
            }

            bool status = Repository.UpdateHousemate(housemate);

            if (status)
            {
                return Ok();
            }

            return BadRequest("Something went wrong");
        }

        [HttpDelete("{id}")]
        public ActionResult DeleteHousemate([FromRoute] int id)
        {
            Housemates existing = Repository.GetHousemateById(id);

            if (existing == null)
            {
                return NotFound($"Housemate with id {id} not found");
            }

            bool status = Repository.DeleteHousemate(id);

            if (status)
            {
                return NoContent();
            }

            return BadRequest($"Unable to delete housemate with id {id}");
        }
    }