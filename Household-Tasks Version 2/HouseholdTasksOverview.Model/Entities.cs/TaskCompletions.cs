namespace HouseholdTasksOverview.Model.Entities.cs;

public class TaskCompletions
{
    public TaskCompletions(int id)
    {
        Id = id;
    }

    public int Id { get; set; }
    
    //this refers the the id key of TaskAssigmentId and is just shorter
    public int AssignmentId { get; set; }

    public DateTime CompletedAt { get; set; }


}
