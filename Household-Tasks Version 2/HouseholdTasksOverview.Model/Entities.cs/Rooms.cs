namespace HouseholdTasksOverview.Model.Entities.cs;

public class Room
{
     public int Id { get; set; }
    
    // Links this room to a specific household (NOT NULL in DB)
    public int HouseholdId { get; set; }
    
    // The name of the room (e.g., "Kitchen", "Living Room") (NOT NULL in DB)
    public string Name { get; set; }
    
    // Optional description of the room (Nullable in DB, so we use ?)
    public string? Description { get; set; }

}
