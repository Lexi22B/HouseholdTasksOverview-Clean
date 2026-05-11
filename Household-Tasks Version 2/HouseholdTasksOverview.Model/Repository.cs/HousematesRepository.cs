
namespace HouseholdTasksOverview.Model.Repository.cs;
using System;
using System.Collections.Generic; //for GetHousemates() function and return a List so we can have a Housemate list
using HouseholdTasksOverview.Model.Entities;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;

    public class HousematesRepository : BaseRepository
    {
        public HousematesRepository(IConfiguration configuration) : base(configuration) { }

        public Housemates GetHousemateById(int id)
        {
            NpgsqlConnection dbConn = null;
            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();
                cmd.CommandText = "select * from housemates where id = @id";
                cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);

                var data = GetData(dbConn, cmd);
                if (data != null && data.Read())
                {
                    return new Housemates
                    {
                        Id = Convert.ToInt32(data["id"]),
                        HouseholdId = Convert.ToInt32(data["household_id"]),
                        Name = data["name"].ToString(),
                        IsActive = (bool)data["is_active"],
                        // If avatar_id is null in DB, it defaults to 1 so the UI doesn't break
                        AvatarId = data["avatar_id"] != DBNull.Value ? Convert.ToInt32(data["avatar_id"]) : 1
                    };
                }
                return null;
            }
            finally { dbConn?.Close(); }
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
                        housemates.Add(new Housemates
                        {
                            Id = Convert.ToInt32(data["id"]),
                            HouseholdId = Convert.ToInt32(data["household_id"]),
                            Name = data["name"].ToString(),
                            IsActive = (bool)data["is_active"],
                            AvatarId = data["avatar_id"] != DBNull.Value ? Convert.ToInt32(data["avatar_id"]) : 1
                        });
                    }
                }
                return housemates;
            }
            finally { dbConn?.Close(); }
        }

        public bool InsertHousemate(Housemates h)
        {
            NpgsqlConnection dbConn = null;
            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();
                
                cmd.CommandText = @"
                    insert into housemates (household_id, name, is_active, avatar_id)
                    values (@household_id, @name, @is_active, @avatar_id)
                ";

                cmd.Parameters.AddWithValue("@household_id", NpgsqlDbType.Integer, h.HouseholdId);
                cmd.Parameters.AddWithValue("@name", NpgsqlDbType.Text, h.Name);
                cmd.Parameters.AddWithValue("@is_active", NpgsqlDbType.Boolean, h.IsActive);
                cmd.Parameters.AddWithValue("@avatar_id", NpgsqlDbType.Integer, h.AvatarId);

                return InsertData(dbConn, cmd);
            }
            finally { dbConn?.Close(); }
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
                        is_active = @is_active,
                        avatar_id = @avatar_id
                    where id = @id
                ";

                cmd.Parameters.AddWithValue("@household_id", NpgsqlDbType.Integer, h.HouseholdId);
                cmd.Parameters.AddWithValue("@name", NpgsqlDbType.Text, h.Name);
                cmd.Parameters.AddWithValue("@is_active", NpgsqlDbType.Boolean, h.IsActive);
                cmd.Parameters.AddWithValue("@avatar_id", NpgsqlDbType.Integer, h.AvatarId);
                cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, h.Id);

                return UpdateData(dbConn, cmd);
            }
            finally { dbConn?.Close(); }
        }

        public bool DeleteHousemate(int id)
        {
            NpgsqlConnection dbConn = null;
            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();
                cmd.CommandText = "delete from housemates where id = @id";
                cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);

                return DeleteData(dbConn, cmd);
            }
            finally { dbConn?.Close(); }
        }
    }
