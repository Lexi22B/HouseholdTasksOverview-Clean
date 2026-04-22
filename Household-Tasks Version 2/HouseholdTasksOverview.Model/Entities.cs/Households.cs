namespace HouseholdTasksOverview.Model.Entities.cs;

public class Households
{
public Households (int id)
 	{
       	 Id = id;
   	 }
	
public int Id { get; set; }

public string Address { get; set; }

 public string PasswordHash { get; set; } 

}
