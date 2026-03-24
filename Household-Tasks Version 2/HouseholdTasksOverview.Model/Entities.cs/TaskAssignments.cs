namespace HouseholdTasksOverview.Model.Entities.cs;

public class TaskAssignments
{
    public TaskAssignments(int id)
    {
        Id = id;
    }

    public int Id { get; set; }

    public int TaskId { get; set; }

    public int HousemateId { get; set; }

    public DateOnly AssignedDate { get; set; }

    public DateOnly DueDate { get; set; }

    public string Status { get; set; }
}
