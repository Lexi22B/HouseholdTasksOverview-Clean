using HouseholdTasksOverview.Model.Entities.cs;
using HouseholdTasksOverview.Model.Repository.cs;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class HouseholdsController : ControllerBase
{
    protected HouseholdsRepository Repository { get; }

    public HouseholdsController(HouseholdsRepository repository)
    {
        Repository = repository;
    }

    [HttpGet("{id}")]
    public ActionResult<Households> GetHousehold([FromRoute] int id)
    {
        Households household = Repository.GetHouseholdById(id);

        if (household == null)
        {
            return NotFound($"Household with id {id} not found");
        }

        return Ok(household);
    }

    [HttpGet]
    public ActionResult<IEnumerable<Households>> GetAllHouseholds()
    {
        return Ok(Repository.GetHouseholds());
    }

    [HttpPost("login")]
    public ActionResult Login([FromBody] HouseholdLoginRequest request)
    {
        if (request == null)
        {
            return BadRequest("Login information is missing");
        }

        if (string.IsNullOrWhiteSpace(request.HouseCode))
        {
            return BadRequest("House ID is required");
        }

        if (string.IsNullOrWhiteSpace(request.Password))
        {
            return BadRequest("Password is required");
        }

        Households household = Repository.LoginHousehold(request.HouseCode, request.Password);

        if (household == null)
        {
            return Unauthorized("Invalid house ID or password");
        }

        return Ok(household);
    }

    [HttpPost]
    public ActionResult Post([FromBody] Households household)
    {
        if (household == null)
        {
            return BadRequest("Household info not correct");
        }

        if (string.IsNullOrWhiteSpace(household.HouseCode))
        {
            return BadRequest("House code is required");
        }

        if (string.IsNullOrWhiteSpace(household.PasswordHash))
        {
            return BadRequest("Password is required");
        }

        bool status = Repository.InsertHousehold(household);

        if (status)
        {
            return Ok();
        }

        return BadRequest("Unable to insert household");
    }

    [HttpPut]
    public ActionResult UpdateHousehold([FromBody] Households household)
    {
        if (household == null)
        {
            return BadRequest("Household info not correct");
        }

        if (string.IsNullOrWhiteSpace(household.HouseCode))
        {
            return BadRequest("House code is required");
        }

        if (string.IsNullOrWhiteSpace(household.PasswordHash))
        {
            return BadRequest("Password is required");
        }

        Households existing = Repository.GetHouseholdById(household.Id);

        if (existing == null)
        {
            return NotFound($"Household with id {household.Id} not found");
        }

        bool status = Repository.UpdateHousehold(household);

        if (status)
        {
            return Ok();
        }

        return BadRequest("Something went wrong");
    }

    [HttpDelete("{id}")]
    public ActionResult DeleteHousehold([FromRoute] int id)
    {
        Households existing = Repository.GetHouseholdById(id);

        if (existing == null)
        {
            return NotFound($"Household with id {id} not found");
        }

        bool status = Repository.DeleteHousehold(id);

        if (status)
        {
            return NoContent();
        }

        return BadRequest($"Unable to delete household with id {id}");
    }
}

public class HouseholdLoginRequest
{
    public string HouseCode { get; set; }
    public string Password { get; set; }
}