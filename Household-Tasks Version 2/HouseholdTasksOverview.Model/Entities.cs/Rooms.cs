namespace HouseholdTasksOverview.Model.Entities.cs;

public class Room
{
    public int Id { get; set; }
    public int HouseholdId { get; set; }
    public string RoomName { get; set; }
    
    public string? ImageUrl { get; set; } // <-- Add this line! (The '?' makes it nullable)
}
