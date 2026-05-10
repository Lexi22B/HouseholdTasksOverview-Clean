namespace HouseholdTasksOverview.Model.Repository.cs;

using System;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;

public class HouseholdsRepository : BaseRepository
{
    public HouseholdsRepository(IConfiguration configuration) : base(configuration)
    {
    }

    // Gets one household from the database and returns its object
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
                    PasswordHash = data["password_hash"].ToString(),
                    HouseCode = data["house_code"].ToString()
                };
            }

            return null;
        }
        finally
        {
            dbConn?.Close();
        }
    }

    // Gets all households
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
                        PasswordHash = data["password_hash"].ToString(),
                        HouseCode = data["house_code"].ToString()
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

    // Login: checks whether the entered House ID and password exist in the households table
   public Households LoginHousehold(string houseCode, string password)
{
    NpgsqlConnection dbConn = null;

    try
    {
        dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();

        cmd.CommandText = @"
            select *
            from households
            where house_code = @house_code
            and password_hash = crypt(@password, password_hash)
        ";

        cmd.Parameters.AddWithValue("@house_code", NpgsqlDbType.Text, houseCode);
        cmd.Parameters.AddWithValue("@password", NpgsqlDbType.Text, password);

        var data = GetData(dbConn, cmd);

        if (data != null && data.Read())
        {
            return new Households(Convert.ToInt32(data["id"]))
            {
                PasswordHash = data["password_hash"].ToString(),
                HouseCode = data["house_code"].ToString()
            };
        }

        return null;
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
            insert into households (password_hash, house_code)
            values (crypt(@password_hash, gen_salt('bf')), @house_code)
        ";
        cmd.Parameters.AddWithValue("@password_hash", NpgsqlDbType.Text, h.PasswordHash ?? "");
        cmd.Parameters.AddWithValue("@house_code", NpgsqlDbType.Text, h.HouseCode);

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
                set password_hash = @password_hash,
                    house_code = @house_code
                where id = @id
            ";

            cmd.Parameters.AddWithValue("@password_hash", NpgsqlDbType.Text, h.PasswordHash ?? "");
            cmd.Parameters.AddWithValue("@house_code", NpgsqlDbType.Text, h.HouseCode);
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

       // Updates password - used for home info pop up 
public bool UpdateHouseholdPassword(int id, string newPassword)
{
    NpgsqlConnection dbConn = null;

    try
    {
        dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();

        cmd.CommandText = @"
            update households
            set password_hash = crypt(@new_password, gen_salt('bf'))
            where id = @id
        ";

        cmd.Parameters.AddWithValue("@new_password", NpgsqlDbType.Text, newPassword);
        cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);

        bool result = UpdateData(dbConn, cmd);
        return result;
    }
    finally
    {
        dbConn?.Close();
    }
}

}