var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<HouseholdsRepository, HouseholdsRepository>();
builder.Services.AddScoped<HousematesRepository, HousematesRepository>();
builder.Services.AddScoped<RoomsRepository, RoomsRepository>();
builder.Services.AddScoped<TaskAssignmentsRepository, TaskAssignmentsRepository>();
builder.Services.AddScoped<TasksCompletionsRepository, TasksCompletionsRepository>();
builder.Services.AddScoped<TasksRepository, TasksRepository>(); //dependency injection


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger(); //test on browser
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
