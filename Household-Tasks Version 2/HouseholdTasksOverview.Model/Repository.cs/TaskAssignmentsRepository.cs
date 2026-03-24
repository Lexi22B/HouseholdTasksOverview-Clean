
namespace HouseholdTasksOverview.Model.Repository.cs;
using System;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;
public class TaskAssignmentsRepository : BaseRepository
//change student to taskassignment
{
public TaskAssignmentsRepository(IConfiguration configuration) : base(configuration)
{ }

//GET ONE ASSIGNMENT BY ID
 public TaskAssignments GetTaskAssignmentById(int id)
    {
        NpgsqlConnection dbConn = null;
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "select * from taskassignments where id = @id";
            cmd.Parameters.Add("@id", NpgsqlDbType.Integer).Value = id;

            var data = GetData(dbConn, cmd);
            if (data != null)
            {
                if (data.Read())
                {
                    return new TaskAssignments(Convert.ToInt32(data["id"]))
                    {
                        TaskId       = Convert.ToInt32(data["task_id"]),
                        HousemateId  = Convert.ToInt32(data["housemate_id"]),
                        AssignedDate = DateOnly.FromDateTime(Convert.ToDateTime(data["assigned_date"])),
                        DueDate      = DateOnly.FromDateTime(Convert.ToDateTime(data["due_date"])),
                        Status       = data["status"].ToString()
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

//GET ALL TASK ASSIGNMENTS
public List<TaskAssignments> GetAllTaskAssignments()
    {
        NpgsqlConnection dbConn = null;
        var assignments = new List<TaskAssignments>();
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = "select * from taskassignments";

            var data = GetData(dbConn, cmd);
            if (data != null)
            {
                while (data.Read())
                {
                    TaskAssignments a = new TaskAssignments(Convert.ToInt32(data["id"]))
                    {
                        TaskId       = Convert.ToInt32(data["task_id"]),
                        HousemateId  = Convert.ToInt32(data["housemate_id"]),
                        AssignedDate = DateOnly.FromDateTime(Convert.ToDateTime(data["assigned_date"])),
                        DueDate      = DateOnly.FromDateTime(Convert.ToDateTime(data["due_date"])),
                        Status       = data["status"].ToString() 
                    };
                    assignments.Add(a);
                }
            }
            return assignments;
        }
        finally
        {
            dbConn?.Close();
        }
    }


//INSERT TASK ASSIGNMENT
public bool InsertTaskAssignment(TaskAssignments a)
    {
        NpgsqlConnection dbConn = null;
        try
        {
            dbConn = new NpgsqlConnection(ConnectionString);
            var cmd = dbConn.CreateCommand();
            cmd.CommandText = @"
                insert into taskassignments
                    (task_id, housemate_id, assigned_date, due_date)
                values
                    (@task_id, @housemate_id, @assigned_date, @due_date)
            ";


            cmd.Parameters.AddWithValue("@task_id",       NpgsqlDbType.Integer, a.TaskId);
            cmd.Parameters.AddWithValue("@housemate_id",  NpgsqlDbType.Integer, a.HousemateId);
            cmd.Parameters.AddWithValue("@assigned_date", NpgsqlDbType.Date,    a.AssignedDate);
            cmd.Parameters.AddWithValue("@due_date",      NpgsqlDbType.Date,    a.DueDate);
            cmd.Parameters.AddWithValue("@status",        NpgsqlDbType.Varchar, a.Status);

            return InsertData(dbConn, cmd);
        }
        finally
        {
            dbConn?.Close();
        }
    }

//UPDATE TASK ASSIGNMENT
 public bool UpdateTaskAssignment(TaskAssignments a)
    {
        var dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = @"
            update taskassignments set
                task_id       = @task_id,
                housemate_id  = @housemate_id,
                assigned_date = @assigned_date,
                due_date      = @due_date
            where
                id = @id
        ";

        cmd.Parameters.AddWithValue("@task_id",       NpgsqlDbType.Integer, a.TaskId);
        cmd.Parameters.AddWithValue("@housemate_id",  NpgsqlDbType.Integer, a.HousemateId);
        cmd.Parameters.AddWithValue("@assigned_date", NpgsqlDbType.Date,    a.AssignedDate);
        cmd.Parameters.AddWithValue("@due_date",      NpgsqlDbType.Date,    a.DueDate);
        cmd.Parameters.AddWithValue("@id",            NpgsqlDbType.Integer, a.Id);
        cmd.Parameters.AddWithValue("@status", NpgsqlDbType.Varchar, a.Status);

        return UpdateData(dbConn, cmd);
    }


//DELETE TASK ASSIGNMENT
public bool DeleteTaskAssignment(int id)
    {
        var dbConn = new NpgsqlConnection(ConnectionString);
        var cmd = dbConn.CreateCommand();
        cmd.CommandText = @"
            delete from taskassignments
            where id = @id
        ";
        //adding parameters in a better way
        cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);
        
        //will return true if all goes well
        return DeleteData(dbConn, cmd);
    }


}

