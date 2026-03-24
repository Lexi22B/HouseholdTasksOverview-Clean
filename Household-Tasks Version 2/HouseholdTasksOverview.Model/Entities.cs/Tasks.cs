namespace HouseholdTasksOverview.Model.Entities.cs;

public class TaskItem 
{
    public int Id { get; set; }
    public int HouseholdId { get; set; }
    public int? RoomId { get; set; } // Nullable, because room_id can be NULL in DB
    public string Title { get; set; }
    public string? Description { get; set; }
    public int? Difficulty { get; set; }
    public int? Priority { get; set; }
    public int? EstimatedDurationMinutes { get; set; }
    public bool IsRecurring { get; set; }
    public string? RecurrencePattern { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }

}
