
namespace HouseholdTasksOverview.Model.Repository.cs;
using System;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;
 public class HouseholdsRepository : BaseRepository
    {
        public HouseholdsRepository(IConfiguration configuration) : base(configuration) //empty constructor for passing the connection string of the database to the BaseRepository
        {
        }
// gets one household from the database and returns its objects
        public Households GetHouseholdById(int id)
        {
            NpgsqlConnection dbConn = null;

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();
                cmd.CommandText = "select * from households where id = @id";
                cmd.Parameters.Add("@id", NpgsqlDbType.Integer).Value = id;

                var data = GetData(dbConn, cmd);

                if (data != null && data.Read())
                {
                    return new Households(Convert.ToInt32(data["id"]))
                    {
                        Address = data["address"].ToString(),
                        PasswordHash = data["password_hash"].ToString()
                    };
                }

                return null;
            }
            finally
            {
                dbConn?.Close();
            }
        }

        public List<Households> GetHouseholds()
        {
            NpgsqlConnection dbConn = null;
            var households = new List<Households>();

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();
                cmd.CommandText = "select * from households";

                var data = GetData(dbConn, cmd);

                if (data != null)
                {
                    while (data.Read())
                    {
                        Households h = new Households(Convert.ToInt32(data["id"]))
                        {
                            Address = data["address"].ToString(),
                            PasswordHash = data["password_hash"].ToString()
                        };

                        households.Add(h);
                    }
                }

                return households;
            }
            finally
            {
                dbConn?.Close();
            }
        }

        public bool InsertHousehold(Households h)
        {
            NpgsqlConnection dbConn = null;

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();

                cmd.CommandText = @"
                    insert into households (address)
                    values (@address)
                ";

                cmd.Parameters.AddWithValue("@address", NpgsqlDbType.Text, h.Address);
                cmd.Parameters.AddWithValue("@password_hash", NpgsqlDbType.Text, h.PasswordHash ?? "");

                bool result = InsertData(dbConn, cmd);
                return result;
            }
            finally
            {
                dbConn?.Close();
            }
        }

        public bool UpdateHousehold(Households h)
        {
            NpgsqlConnection dbConn = null;

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();

                cmd.CommandText = @"
                    update households
                    set address = @address
                    where id = @id
                ";

                cmd.Parameters.AddWithValue("@address", NpgsqlDbType.Text, h.Address);
                cmd.Parameters.AddWithValue("@password_hash", NpgsqlDbType.Text, h.PasswordHash ?? "");
                cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, h.Id);

                bool result = UpdateData(dbConn, cmd);
                return result;
            }
            finally
            {
                dbConn?.Close();
            }
        }

        public bool DeleteHousehold(int id)
        {
            NpgsqlConnection dbConn = null;

            try
            {
                dbConn = new NpgsqlConnection(ConnectionString);
                var cmd = dbConn.CreateCommand();

                cmd.CommandText = @"
                    delete from households
                    where id = @id
                ";

                cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);

                bool result = DeleteData(dbConn, cmd);
                return result;
            }
            finally
            {
                dbConn?.Close();
            }
        }
    }
