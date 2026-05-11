namespace HouseholdTasksOverview.Model.Repository.cs;

using System;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;

public class RoomsRepository : BaseRepository
{
    public RoomsRepository(IConfiguration configuration) : base(configuration)
    {
    }

    public virtual Room GetRoomById(int id)
    {
        NpgsqlConnection dbConn = null;
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "SELECT * FROM rooms WHERE id = @id";
            cmd.Parameters.Add("@id", NpgsqlDbType.Integer).Value = id;

            var data = GetData(dbConn, cmd);
            if (data != null && data.Read())
                return MapDataReaderToRoom(data);
            return null;
        }
        finally { dbConn?.Close(); }
    }

    public virtual List<Room> GetRooms()
    {
        NpgsqlConnection dbConn = null;
        var rooms = new List<Room>();
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "SELECT * FROM rooms";

            var data = GetData(dbConn, cmd);
            if (data != null)
                while (data.Read())
                    rooms.Add(MapDataReaderToRoom(data));
            return rooms;
        }
        finally { dbConn?.Close(); }
    }

    public virtual int InsertRoom(Room r)
    {
    NpgsqlConnection dbConn = null;
    try
    {
        dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = @"
        INSERT INTO rooms (household_id, room_name, image_url) 
        VALUES (@household_id, @room_name, @image_url)
        RETURNING id";

        cmd.Parameters.AddWithValue("@household_id", NpgsqlDbType.Integer, r.HouseholdId);
        cmd.Parameters.AddWithValue("@room_name", NpgsqlDbType.Varchar, r.RoomName);
        // Add this line for the image:
        cmd.Parameters.AddWithValue("@image_url", NpgsqlDbType.Varchar, (object)r.ImageUrl ?? DBNull.Value);

        dbConn.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }
    finally { dbConn?.Close(); }
    }

    public virtual bool UpdateRoom(Room r)
    {
    var dbConn = new NpgsqlConnection(ConnectionString);
    var cmd = dbConn.CreateCommand();
    cmd.CommandText = @"
        UPDATE rooms 
        SET household_id = @household_id, 
            room_name = @room_name,
            image_url = @image_url
        WHERE id = @id";

    cmd.Parameters.AddWithValue("@household_id", NpgsqlDbType.Integer, r.HouseholdId);
    cmd.Parameters.AddWithValue("@room_name", NpgsqlDbType.Varchar, r.RoomName);
    // Add this line:
    cmd.Parameters.AddWithValue("@image_url", NpgsqlDbType.Varchar, (object)r.ImageUrl ?? DBNull.Value);
    cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, r.Id);

    return UpdateData(dbConn, cmd);
    }

    public virtual bool DeleteRoom(int id)
    {
        var dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = "DELETE FROM rooms WHERE id = @id";
        cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);
        return DeleteData(dbConn, cmd);
    }

    private Room MapDataReaderToRoom(NpgsqlDataReader data)
{
    return new Room
    {
        Id = Convert.ToInt32(data["id"]),
        HouseholdId = Convert.ToInt32(data["household_id"]),
        RoomName = data["room_name"].ToString(),
        // Add this line to read the image_url from the database:
        ImageUrl = data["image_url"] == DBNull.Value ? null : data["image_url"].ToString()
    };
}
}