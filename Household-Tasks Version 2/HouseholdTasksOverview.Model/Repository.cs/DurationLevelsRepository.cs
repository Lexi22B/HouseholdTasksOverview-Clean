namespace HouseholdTasksOverview.Model.Repository.cs;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;

public class DurationLevelsRepository : BaseRepository
{
    public DurationLevelsRepository(IConfiguration configuration) : base(configuration) { }

    public List<DurationLevel> GetAll()
    {
        NpgsqlConnection dbConn = null;
        var list = new List<DurationLevel>();
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "SELECT * FROM duration_levels ORDER BY id";
            var data = GetData(dbConn, cmd);
            if (data != null)
            {
                while (data.Read())
                {
                    list.Add(new DurationLevel
                    {
                        Id      = Convert.ToInt32(data["id"]),
                        Minutes = Convert.ToInt32(data["minutes"])
                    });
                }
            }
            return list;
        }
        finally { dbConn?.Close(); }
    }
}