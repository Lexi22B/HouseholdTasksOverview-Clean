
using HouseholdTasksOverview.Model.Entities;
using HouseholdTasksOverview.Model.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace HouseholdTasksOverview.API.Controllers;
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoomController : ControllerBase
    {
        protected RoomsRepository Repository { get; }
        
        public RoomController(RoomsRepository repository)
        {
            Repository = repository;
        }

        [HttpGet("{id}")]
        public ActionResult<Room> GetRoom([FromRoute] int id)
        {
            Room room = Repository.GetRoomById(id);
            if (room == null)
            {
                return NotFound();
            }
            return Ok(room);
        }

        [HttpGet]
        public ActionResult<IEnumerable<Room>> GetRooms()
        {
            return Ok(Repository.GetRooms());
        }

        [HttpPost]
        public ActionResult Post([FromBody] Room room)
        {
            if (room == null)
            {
                return BadRequest("Room info is not correct");
            }
            
            bool status = Repository.InsertRoom(room);
            if (status)
            {
                return Ok();
            }
            return BadRequest("Failed to create the room in the database.");
        }

        [HttpPut]
        public ActionResult UpdateRoom([FromBody] Room room)
        {
            if (room == null)
            {
                return BadRequest("Room info is not correct");
            }
            
            Room existingRoom = Repository.GetRoomById(room.Id);
            if (existingRoom == null)
            {
                return NotFound($"Room with id {room.Id} not found");
            }
            
            bool status = Repository.UpdateRoom(room);
            if (status)
            {
                return Ok();
            }
            return BadRequest("Something went wrong while updating the room");
        }

        [HttpDelete("{id}")]
        public ActionResult DeleteRoom([FromRoute] int id)
        {
            Room existingRoom = Repository.GetRoomById(id);
            if (existingRoom == null)
            {
                return NotFound($"Room with id {id} not found");
            }
            
            bool status = Repository.DeleteRoom(id);
            if (status)
            {
                return NoContent();
            }
            return BadRequest($"Unable to delete room with id {id}");
        }
    }
}