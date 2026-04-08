namespace HouseholdTasksOverview.Model.Repository.cs;
using System;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;

public class TasksRepository : BaseRepository
{
    public TasksRepository(IConfiguration configuration) : base(configuration)
    { }

   // --- GET TASK BY ID ---
public Tasks GetTaskById(int id)
{
    NpgsqlConnection dbConn = null;
    try
    {
        dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = "select * from tasks where id = @id";
        cmd.Parameters.Add("@id", NpgsqlDbType.Integer).Value = id;

        var data = GetData(dbConn, cmd);
        if (data != null)
        {
            if (data.Read())
            {
                return new Tasks
                {
                    Id                       = Convert.ToInt32(data["id"]),
                    HouseholdId              = Convert.ToInt32(data["household_id"]),
                    RoomId                   = data["room_id"] == DBNull.Value ? null : Convert.ToInt32(data["room_id"]),
                    Title                    = data["title"].ToString(),
                    Description              = data["description"] == DBNull.Value ? null : data["description"].ToString(),
                    Difficulty               = data["difficulty_level_id"] == DBNull.Value ? null : Convert.ToInt32(data["difficulty_level_id"]),
                    Priority                 = data["priority_level_id"] == DBNull.Value ? null : Convert.ToInt32(data["priority_level_id"]),
                    EstimatedDurationMinutes = data["duration_level_id"] == DBNull.Value ? null : Convert.ToInt32(data["duration_level_id"]),
                    IsRecurring              = Convert.ToBoolean(data["task_frequency_id"]),
                    RecurrencePattern        = data["recurrence_pattern"] == DBNull.Value ? null : data["recurrence_pattern"].ToString(),
                    IsActive                 = Convert.ToBoolean(data["is_active"]),
                    CreatedAt                = Convert.ToDateTime(data["created_at"])
                };
            }
        }
        return null;
    }
    finally
    {
        dbConn?.Close();
    }
}

// --- GET ALL TASKS ---
public List<Tasks> GetAllTasks()
{
    NpgsqlConnection dbConn = null;
    var tasks = new List<Tasks>();
    try
    {
        dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = "select * from tasks";

        var data = GetData(dbConn, cmd);
        if (data != null)
        {
            while (data.Read())
            {
                tasks.Add(new Tasks
                {
                    Id                       = Convert.ToInt32(data["id"]),
                    HouseholdId              = Convert.ToInt32(data["household_id"]),
                    RoomId                   = data["room_id"] == DBNull.Value ? null : Convert.ToInt32(data["room_id"]),
                    Title                    = data["title"].ToString(),
                    Description              = data["description"] == DBNull.Value ? null : data["description"].ToString(),
                    Difficulty               = data["difficulty_level_id"] == DBNull.Value ? null : Convert.ToInt32(data["difficulty_level_id"]),
                    Priority                 = data["priority_level_id"] == DBNull.Value ? null : Convert.ToInt32(data["priority_level_id"]),
                    EstimatedDurationMinutes = data["duration_level_id"] == DBNull.Value ? null : Convert.ToInt32(data["duration_level_id"]),
                    IsRecurring              = Convert.ToBoolean(data["task_frequency_id"]),
                    RecurrencePattern        = data["recurrence_pattern"] == DBNull.Value ? null : data["recurrence_pattern"].ToString(),
                    IsActive                 = Convert.ToBoolean(data["is_active"]),
                    CreatedAt                = Convert.ToDateTime(data["created_at"])
                });
            }
        }
        return tasks;
    }
    finally
    {
        dbConn?.Close();
    }
}

// --- INSERT NEW TASK ---
public bool InsertTask(Tasks t)
{
    NpgsqlConnection dbConn = null;
    try
    {
        dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = @"
            insert into tasks
                (household_id, room_id, task_frequency_id, recurrence_pattern,
                 title, description, difficulty_level_id, priority_level_id,
                 duration_level_id, is_active)
            values
                (@household_id, @room_id, @task_frequency_id, @recurrence_pattern,
                 @title, @description, @difficulty_level_id, @priority_level_id,
                 @duration_level_id, @is_active)
        ";

        cmd.Parameters.AddWithValue("@household_id",        NpgsqlDbType.Integer, t.HouseholdId);
        cmd.Parameters.AddWithValue("@room_id",             NpgsqlDbType.Integer, (object)t.RoomId ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@task_frequency_id",   NpgsqlDbType.Boolean, t.IsRecurring);
        cmd.Parameters.AddWithValue("@recurrence_pattern",  NpgsqlDbType.Varchar, (object)t.RecurrencePattern ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@title",               NpgsqlDbType.Varchar, t.Title);
        cmd.Parameters.AddWithValue("@description",         NpgsqlDbType.Text,    (object)t.Description ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@difficulty_level_id", NpgsqlDbType.Integer, (object)t.Difficulty ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@priority_level_id",   NpgsqlDbType.Integer, (object)t.Priority ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@duration_level_id",   NpgsqlDbType.Integer, (object)t.EstimatedDurationMinutes ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@is_active",           NpgsqlDbType.Boolean, t.IsActive);

        return InsertData(dbConn, cmd);
    }
    finally
    {
        dbConn?.Close();
    }
}

// --- UPDATE EXISTING TASK ---
public bool UpdateTask(Tasks t)
{
    var dbConn = new NpgsqlConnection(ConnectionString);
    var cmd = dbConn.CreateCommand();
    cmd.CommandText = @"
        update tasks set
            household_id        = @household_id,
            room_id             = @room_id,
            task_frequency_id   = @task_frequency_id,
            recurrence_pattern  = @recurrence_pattern,
            title               = @title,
            description         = @description,
            difficulty_level_id = @difficulty_level_id,
            priority_level_id   = @priority_level_id,
            duration_level_id   = @duration_level_id,
            is_active           = @is_active
        where
            id = @id
    ";

    cmd.Parameters.AddWithValue("@household_id",        NpgsqlDbType.Integer, t.HouseholdId);
    cmd.Parameters.AddWithValue("@room_id",             NpgsqlDbType.Integer, (object)t.RoomId ?? DBNull.Value);
    cmd.Parameters.AddWithValue("@task_frequency_id",   NpgsqlDbType.Boolean, t.IsRecurring);
    cmd.Parameters.AddWithValue("@recurrence_pattern",  NpgsqlDbType.Varchar, (object)t.RecurrencePattern ?? DBNull.Value);
    cmd.Parameters.AddWithValue("@title",               NpgsqlDbType.Varchar, t.Title);
    cmd.Parameters.AddWithValue("@description",         NpgsqlDbType.Text,    (object)t.Description ?? DBNull.Value);
    cmd.Parameters.AddWithValue("@difficulty_level_id", NpgsqlDbType.Integer, (object)t.Difficulty ?? DBNull.Value);
    cmd.Parameters.AddWithValue("@priority_level_id",   NpgsqlDbType.Integer, (object)t.Priority ?? DBNull.Value);
    cmd.Parameters.AddWithValue("@duration_level_id",   NpgsqlDbType.Integer, (object)t.EstimatedDurationMinutes ?? DBNull.Value);
    cmd.Parameters.AddWithValue("@is_active",           NpgsqlDbType.Boolean, t.IsActive);
    cmd.Parameters.AddWithValue("@id",                  NpgsqlDbType.Integer, t.Id);

    return UpdateData(dbConn, cmd);
}

// --- DELETE TASK ---
public bool DeleteTask(int id)
{
    var dbConn = new NpgsqlConnection(ConnectionString);
    var cmd = dbConn.CreateCommand();
    cmd.CommandText = "delete from tasks where id = @id";
    cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);
    return DeleteData(dbConn, cmd);
}
}