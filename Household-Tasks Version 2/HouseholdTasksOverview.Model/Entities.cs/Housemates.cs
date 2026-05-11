namespace HouseholdTasksOverview.Model.Entities.cs;

public class Housemates
{
    // The empty one for Angular to use when receiving new data
    public Housemates() { } 

    // The one your teammates wrote
    public Housemates(int id)
    {
        Id = id;
    }

    public int Id { get; set; }
    public int HouseholdId { get; set; }
    public string Name { get; set; }
    public bool IsActive { get; set; }
    public int AvatarId { get; set; }
}
