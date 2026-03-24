
namespace HouseholdTasksOverview.Model.Repository.cs;
using System;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;
public class TaskCompletionsRepository : BaseRepository
//change student to TaskCompletionsRepository
{
public TaskCompletionsRepository(IConfiguration configuration) : base(configuration)
{ }

//GET ONE TASK COMPLETION BY ID
public TaskCompletions GetTaskCompletionById(int id)
    {
        NpgsqlConnection dbConn = null;
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "select * from task_completions where id = @id";
            cmd.Parameters.Add("@id", NpgsqlDbType.Integer).Value = id;

            var data = GetData(dbConn, cmd);
            if (data != null)
            {
                if (data.Read())
                {
                    return new TaskCompletions(Convert.ToInt32(data["id"]))
                    {
                        AssignmentId = Convert.ToInt32(data["assignment_id"]),
                        CompletedAt  = Convert.ToDateTime(data["completed_at"])
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

//GET ALL TASK COMPLETIONS
 public List<TaskCompletions> GetAllTaskCompletions()
    {
        NpgsqlConnection dbConn = null;
        var completions = new List<TaskCompletions>();
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "select * from task_completions";

            var data = GetData(dbConn, cmd);
            if (data != null)
            {
                while (data.Read())
                {
                    TaskCompletions c = new TaskCompletions(Convert.ToInt32(data["id"]))
                    {
                        AssignmentId = Convert.ToInt32(data["assignment_id"]),
                        CompletedAt  = Convert.ToDateTime(data["completed_at"])
                    };
                    completions.Add(c);
                }
            }
            return completions;
        }
        finally
        {
            dbConn?.Close();
        }
    }

//INSERT TASK COMPLETIONS
public bool InsertTaskCompletion(TaskCompletions c)
    {
        NpgsqlConnection dbConn = null;
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = @"
                insert into task_completions
                    (assignment_id, completed_at)
                values
                    (@assignment_id, @completed_at)
            ";

            cmd.Parameters.AddWithValue("@assignment_id", NpgsqlDbType.Integer,   c.AssignmentId);
            cmd.Parameters.AddWithValue("@completed_at",  NpgsqlDbType.Timestamp, c.CompletedAt);

            return InsertData(dbConn, cmd);
        }
        finally
        {
            dbConn?.Close();
        }
    }


//UPDATE TASK COMPLETIONS
public bool UpdateTaskCompletion(TaskCompletions c)
    {
        var dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = @"
            update task_completions set
                assignment_id = @assignment_id,
                completed_at  = @completed_at
            where
                id = @id
        ";

        cmd.Parameters.AddWithValue("@assignment_id", NpgsqlDbType.Integer,   c.AssignmentId);
        cmd.Parameters.AddWithValue("@completed_at",  NpgsqlDbType.Timestamp, c.CompletedAt);
        cmd.Parameters.AddWithValue("@id",            NpgsqlDbType.Integer,   c.Id);

        return UpdateData(dbConn, cmd);
    }

//DELETE TASK COMPLETION - rarely used
    public bool DeleteTaskCompletion(int id)
    {
        var dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = @"
            delete from task_completions
            where id = @id
        ";

        cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);

        return DeleteData(dbConn, cmd);
    }
}


