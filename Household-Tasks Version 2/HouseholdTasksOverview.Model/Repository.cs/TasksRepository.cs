namespace HouseholdTasksOverview.Model.Repository.cs;
using System;
using HouseholdTasksOverview.Model.Entities;
using HouseholdTasksOverview.Model.Entities.cs;
using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;
public class TasksRepository : BaseRepository
//change student to TasksRepository
{
public TasksRepository(IConfiguration configuration) : base(configuration)
{ }

//Get Task By ID
public TaskItem GetStudentById(int id)
{
NpgsqlConnection dbConn = null;
try
{
//create a new connection for database
dbConn = new NpgsqlConnection(ConnectionString);
//creating an SQL command
var cmd = dbConn.CreateCommand();
cmd.CommandText = "select * from student where id = @id";
cmd.Parameters.Add("@id", NpgsqlDbType.Integer).Value = id;
//call the base method to get data
var data = GetData(dbConn, cmd);
if (data != null)
{
if (data.Read()) //every time loop runs it reads next like from 
fetched rows
{
return MapDataReaderToTaskItem(data); //part of the code was deleted here. Student ID properties
}
}
return null;
}
finally
{
dbConn?.Close();
}
}

//--- Get All Tasks ---
public List<TaskItem> GetStudents()
{
NpgsqlConnection dbConn = null;
var tasks = new List<TaskItem>();
try
{
//create a new connection for database
dbConn = new NpgsqlConnection(ConnectionString);
//creating an SQL command
var cmd = dbConn.CreateCommand();
cmd.CommandText = "select * from student";
//call the base method to get data
var data = GetData(dbConn, cmd);
if (data != null)
{
while (data.Read()) //every time loop runs it reads next like from
fetched rows
{
 tasks.Add(MapDataReaderToTaskItem(data)); //part of the original code was substituted. Info about student 
}
}
return tasks;
}
finally
{
dbConn?.Close();
}
}
// -- Add New Task --
public bool InsertTask(TaskItem t)
{
NpgsqlConnection dbConn = null;
try
{
dbConn = new NpgsqlConnection(ConnectionString);
var cmd = dbConn.CreateCommand();
cmd.CommandText = @"
insert into tasks
(household_id, room_id, title, description, difficulty, priority, estimated_duration_minutes, is_recurring, recurrence_pattern, is_active) 
values
(@household_id, @room_id, @title, @description, @difficulty, @priority, @estimated_duration_minutes, @is_recurring, @recurrence_pattern, @is_active)
"; //COME BACK TO THIS FINISH THIS PART:
//adding parameters in a better way
cmd.Parameters.AddWithValue("@household_id", NpgsqlDbType.Text,
s.FirstName);
cmd.Parameters.AddWithValue("@title", NpgsqlDbType.Text,
s.LastName);
cmd.Parameters.AddWithValue("@room_id", NpgsqlDbType.Integer,
s.StudyProgramId);
cmd.Parameters.AddWithValue("@dob", NpgsqlDbType.Date, s.DateOfBirth);
cmd.Parameters.AddWithValue("@email", NpgsqlDbType.Text, s.Email);
cmd.Parameters.AddWithValue("@phone", NpgsqlDbType.Text, s.Phone);
//will return true if all goes well
bool result = InsertData(dbConn, cmd);
return result;
}
finally
{
dbConn?.Close();
}
}
// --- UPDATE EXISTING TASK ---
public bool UpdateTask(TaskItem t)
{
var dbConn = new NpgsqlConnection(ConnectionString);
var cmd = dbConn.CreateCommand();
cmd.CommandText = @"
UPDATE tasks SET 
household_id = @household_id, 
room_id = @room_id, 
title = @title, 
description = @description, 
difficulty = @difficulty, 
priority = @priority, 
estimated_duration_minutes = @estimated_duration_minutes, 
is_recurring = @is_recurring, 
recurrence_pattern = @recurrence_pattern, 
is_active = @is_active
WHERE id = @id";
//COME BACK TO THIS FINISH/REVIEW THIS PART:
cmd.Parameters.AddWithValue("@firstname", NpgsqlDbType.Text, s.FirstName);
cmd.Parameters.AddWithValue("@lastname", NpgsqlDbType.Text, s.LastName);
cmd.Parameters.AddWithValue("@studyprogramid", NpgsqlDbType.Integer,
s.StudyProgramId);
cmd.Parameters.AddWithValue("@dob", NpgsqlDbType.Date, s.DateOfBirth);
cmd.Parameters.AddWithValue("@email", NpgsqlDbType.Text, s.Email);
cmd.Parameters.AddWithValue("@phone", NpgsqlDbType.Text, s.Phone);
cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, s.Id);
bool result = UpdateData(dbConn, cmd);
return result;
}
public bool DeleteTask(int id)
{
var dbConn = new NpgsqlConnection(ConnectionString);
var cmd = dbConn.CreateCommand();
cmd.CommandText = "DELETE FROM tasks WHERE id = @id";
//adding parameters in a better way
cmd.Parameters.AddWithValue("@id", NpgsqlDbType.Integer, id);
//will return true if all goes well
bool result = DeleteData(dbConn, cmd);
return result;
}
}


