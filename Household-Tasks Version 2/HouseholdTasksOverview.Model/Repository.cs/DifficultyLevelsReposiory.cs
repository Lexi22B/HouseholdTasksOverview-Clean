namespace HouseholdTasksOverview.Model.Repository.cs;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;

public class DifficultyLevelsRepository : BaseRepository
{
    public DifficultyLevelsRepository(IConfiguration configuration) : base(configuration) { }

    public List<DifficultyLevel> GetAll()
    {
        NpgsqlConnection dbConn = null;
        var list = new List<DifficultyLevel>();
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "SELECT * FROM difficulty_levels ORDER BY id";
            var data = GetData(dbConn, cmd);
            if (data != null)
            {
                while (data.Read())
                {
                    list.Add(new DifficultyLevel
                    {
                        Id   = Convert.ToInt32(data["id"]),
                        Name = data["name"].ToString()
                    });
                }
            }
            return list;
        }
        finally { dbConn?.Close(); }
    }
}