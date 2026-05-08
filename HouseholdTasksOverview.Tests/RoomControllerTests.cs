using Xunit;
using Moq;
using Microsoft.AspNetCore.Mvc;
using HouseholdTasksOverview.API.Controllers;
using HouseholdTasksOverview.Model.Entities.cs;
using HouseholdTasksOverview.Model.Repository.cs;

public class RoomControllerTests
{
    private readonly Mock<RoomsRepository> _repoMock;
    private readonly RoomController _controller;

    public RoomControllerTests()
    {
        // We pass null for IConfiguration because the mock
        // won't call the real database methods
        _repoMock = new Mock<RoomsRepository>(null);
        _controller = new RoomController(_repoMock.Object);
    }

    [Fact]
    public void GetRoom_ReturnsNotFound_WhenRoomDoesNotExist()
    {
        // Arrange - set up the mock to return null (room not in DB)
        _repoMock.Setup(r => r.GetRoomById(99)).Returns((Room)null);

        // Act - call the controller method
        var result = _controller.GetRoom(99);

        // Assert - expect a 404 NotFound response
        Assert.IsType<NotFoundResult>(result.Result);
    }
}