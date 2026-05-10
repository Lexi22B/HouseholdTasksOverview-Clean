namespace HouseholdTasksOverview.Model.Repository.cs;
using System;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;

public class TaskAssignmentsRepository : BaseRepository
{
    public TaskAssignmentsRepository(IConfiguration configuration) : base(configuration)
    { }

    public TaskAssignments GetTaskAssignmentById(int id)
    {
        NpgsqlConnection dbConn = null;
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "select * from task_assignments where id = @id";
            cmd.Parameters.Add("@id", NpgsqlDbType.Integer).Value = id;

            var data = GetData(dbConn, cmd);
            if (data != null && data.Read())
            {
                return new TaskAssignments(Convert.ToInt32(data["id"]))
                {
                    TaskId      = Convert.ToInt32(data["task_id"]),
                    HousemateId = Convert.ToInt32(data["housemate_id"])
                };
            }
            return null;
        }
        finally
        {
            dbConn?.Close();
        }
    }

    public List<TaskAssignments> GetAllTaskAssignments()
    {
        NpgsqlConnection dbConn = null;
        var assignments = new List<TaskAssignments>();
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "select * from task_assignments";

            var data = GetData(dbConn, cmd);
            if (data != null)
            {
                while (data.Read())
                {
                    assignments.Add(new TaskAssignments(Convert.ToInt32(data["id"]))
                    {
                        TaskId      = Convert.ToInt32(data["task_id"]),
                        HousemateId = Convert.ToInt32(data["housemate_id"])
                    });
                }
            }
            return assignments;
        }
        finally
        {
            dbConn?.Close();
        }
    }

    public bool InsertTaskAssignment(TaskAssignments a)
    {
        NpgsqlConnection dbConn = null;
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = @"
                insert into task_assignments (task_id, housemate_id)
                values (@task_id, @housemate_id)
            ";

            cmd.Parameters.AddWithValue("@task_id",      NpgsqlDbType.Integer, a.TaskId);
            cmd.Parameters.AddWithValue("@housemate_id", NpgsqlDbType.Integer, a.HousemateId);

            return InsertData(dbConn, cmd);
        }
        finally
        {
            dbConn?.Close();
        }
    }

    public bool UpdateTaskAssignment(TaskAssignments a)
    {
        var dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = @"
            update task_assignments set
                task_id      = @task_id,
                housemate_id = @housemate_id
            where id = @id
        ";

        cmd.Parameters.AddWithValue("@task_id",      NpgsqlDbType.Integer, a.TaskId);
        cmd.Parameters.AddWithValue("@housemate_id", NpgsqlDbType.Integer, a.HousemateId);
        cmd.Parameters.AddWithValue("@id",           NpgsqlDbType.Integer, a.Id);

        return UpdateData(dbConn, cmd);
    }

    public bool DeleteTaskAssignment(int id)
    {
        var dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = "delete from task_assignments where id = @id";
        cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);
        return DeleteData(dbConn, cmd);
    }
}