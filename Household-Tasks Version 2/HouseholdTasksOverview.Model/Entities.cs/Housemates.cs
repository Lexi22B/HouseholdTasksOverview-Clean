namespace HouseholdTasksOverview.Model.Entities.cs;

public class Housemates
{
    public Housemates (int id)
 	{
       	 Id = id;
   	 }
	
public int Id { get; set; }

   	public int HouseholdId { get; set; }

public string Name{ get; set; }
	
public string Email { get; set; }

public bool IsActive { get; set; }

}
