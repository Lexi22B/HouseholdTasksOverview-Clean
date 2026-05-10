namespace HouseholdTasksOverview.Model.Entities.cs;

public class Tasks
{
    public int Id { get; set; }
    public int HouseholdId { get; set; }
    public int? RoomId { get; set; } 
    public string Title { get; set; }
    public int? Difficulty { get; set; }
    public int? Priority { get; set; }
    public int? EstimatedDurationMinutes { get; set; }

}
