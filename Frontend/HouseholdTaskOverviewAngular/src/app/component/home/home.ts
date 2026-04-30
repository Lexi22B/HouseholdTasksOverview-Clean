import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { RoomService } from '../../services/room-service';
import { Room } from '../../model/room';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class HomeComponent implements OnInit {

  rooms: Room[] = [];
  showPopup = false;

  newRoom = {
    name: '',
    selectedImage: 'assets/rooms/room1.png'
  };

  roomImageOptions = [
    'assets/rooms/room1.png',
    'assets/rooms/room2.png',
    'assets/rooms/room3.png'
  ];

  constructor(private router: Router, private roomService: RoomService) {}

  ngOnInit() {
    this.loadRooms();
  }

  loadRooms() {
    this.roomService.getAll().subscribe(rooms => {
      this.rooms = rooms.filter(r => r.householdId === 1);
    });
  }

  goToHouseProfile() {
    this.router.navigate(['/house-profile']);
  }

  goToRoommates() {
    this.router.navigate(['/roommates']);
  }

  openPopup() {
    this.newRoom = { name: '', selectedImage: 'assets/rooms/room1.png' };
    this.showPopup = true;
  }

  closePopup() {
    this.showPopup = false;
  }

  createRoom() {
    if (!this.newRoom.name) return;

    const room: Room = {
      id: 0,
      householdId: 1,
      roomName: this.newRoom.name
    };

    this.roomService.create(room).subscribe((newId: number) => {
      this.closePopup();
      this.router.navigate(['/room', newId], {
        state: { roomName: this.newRoom.name }
      });
    });
  }

  openRoom(room: Room) {
    this.router.navigate(['/room', room.id], {
      state: { roomName: room.roomName }
    });
  }
}