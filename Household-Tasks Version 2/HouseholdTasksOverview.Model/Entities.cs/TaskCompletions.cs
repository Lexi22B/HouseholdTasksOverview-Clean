namespace HouseholdTasksOverview.Model.Entities.cs;

public class TaskCompletions
{
    public TaskCompletions(int id)
    {
        Id = id;
    }

    public int Id { get; set; }
    
    public int AssignmentId { get; set; }


}
