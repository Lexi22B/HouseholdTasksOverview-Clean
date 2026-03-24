
namespace HouseholdTasksOverview.Model.Repository.cs;
using System;
using HouseholdTasksOverview.Model.Entities;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;
 public class HousematesRepository : BaseRepository
    {
        public HousematesRepository(IConfiguration configuration) : base(configuration)
        {
        }

        public Housemates GetHousemateById(int id)
        {
            NpgsqlConnection dbConn = null;

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();
                cmd.CommandText = "select * from housemates where id = @id";
                cmd.Parameters.Add("@id", NpgsqlDbType.Integer).Value = id;

                var data = GetData(dbConn, cmd);

                if (data != null && data.Read())
                {
                    return new Housemates(Convert.ToInt32(data["id"]))
                    {
                        HouseholdId = (int)data["household_id"],
                        Name = data["name"].ToString(),
                        Email = data["email"].ToString(),
                        IsActive = (bool)data["is_active"]
                    };
                }

                return null;
            }
            finally
            {
                dbConn?.Close();
            }
        }

        public List<Housemates> GetHousemates()
        {
            NpgsqlConnection dbConn = null;
            var housemates = new List<Housemates>();

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();
                cmd.CommandText = "select * from housemates";

                var data = GetData(dbConn, cmd);

                if (data != null)
                {
                    while (data.Read())
                    {
                        Housemates h = new Housemates(Convert.ToInt32(data["id"]))
                        {
                            HouseholdId = (int)data["household_id"],
                            Name = data["name"].ToString(),
                            Email = data["email"].ToString(),
                            IsActive = (bool)data["is_active"]
                        };

                        housemates.Add(h);
                    }
                }

                return housemates;
            }
            finally
            {
                dbConn?.Close();
            }
        }

        public bool InsertHousemate(Housemates h)
        {
            NpgsqlConnection dbConn = null;

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();

                cmd.CommandText = @"
                    insert into housemates (household_id, name, email, is_active)
                    values (@household_id, @name, @email, @is_active)
                ";

                cmd.Parameters.AddWithValue("@household_id", NpgsqlDbType.Integer, h.HouseholdId);
                cmd.Parameters.AddWithValue("@name", NpgsqlDbType.Text, h.Name);
                cmd.Parameters.AddWithValue("@email", NpgsqlDbType.Text, h.Email);
                cmd.Parameters.AddWithValue("@is_active", NpgsqlDbType.Boolean, h.IsActive);

                return InsertData(dbConn, cmd);
            }
            finally
            {
                dbConn?.Close();
            }
        }

        public bool UpdateHousemate(Housemates h)
        {
            NpgsqlConnection dbConn = null;

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();

                cmd.CommandText = @"
                    update housemates set
                        household_id = @household_id,
                        name = @name,
                        email = @email,
                        is_active = @is_active
                    where id = @id
                ";

                cmd.Parameters.AddWithValue("@household_id", NpgsqlDbType.Integer, h.HouseholdId);
                cmd.Parameters.AddWithValue("@name", NpgsqlDbType.Text, h.Name);
                cmd.Parameters.AddWithValue("@email", NpgsqlDbType.Text, h.Email);
                cmd.Parameters.AddWithValue("@is_active", NpgsqlDbType.Boolean, h.IsActive);
                cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, h.Id);

                return UpdateData(dbConn, cmd);
            }
            finally
            {
                dbConn?.Close();
            }
        }

        public bool DeleteHousemate(int id)
        {
            NpgsqlConnection dbConn = null;

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();

                cmd.CommandText = @"
                    delete from housemates
                    where id = @id
                ";

                cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);

                return DeleteData(dbConn, cmd);
            }
            finally
            {
                dbConn?.Close();
            }
        }
    }
