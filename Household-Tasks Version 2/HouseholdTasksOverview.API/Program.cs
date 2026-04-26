using HouseholdTasksOverview.Model.Repository.cs;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAngular", policy =>
    {
        policy.WithOrigins("http://localhost:4200")
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<HouseholdsRepository, HouseholdsRepository>();
builder.Services.AddScoped<HousematesRepository, HousematesRepository>();
builder.Services.AddScoped<RoomsRepository, RoomsRepository>();
builder.Services.AddScoped<TaskAssignmentsRepository, TaskAssignmentsRepository>();
builder.Services.AddScoped<TaskCompletionsRepository, TaskCompletionsRepository>();
builder.Services.AddScoped<TasksRepository, TasksRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// app.UseHttpsRedirection();

app.UseCors("AllowAngular");

app.UseAuthorization();

app.MapControllers();

app.Run();