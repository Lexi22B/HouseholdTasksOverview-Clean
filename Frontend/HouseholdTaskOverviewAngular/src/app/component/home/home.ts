import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class HomeComponent {



  constructor(private router: Router) {}

  goToHouseProfile() {
    this.router.navigate(['/house-profile']);
  }

  goToRoommates() {
    this.router.navigate(['/roommates']);
  }

  addRoom() {
    this.router.navigate(['/create-room']);
  }

 //rooms: any[] = [];

rooms = [
  { id: 1, name: 'Kitchen', image: 'assets/rooms/default.png' }
];

/*openRoom(id: number) {
  this.router.navigate(['/room', id], {
    state: { roomName: 'Room', roomImage: 'assets/rooms/default.png' }
  });
}*/

openRoom(room: any) {
  this.router.navigate(['/room', room.id], {
    state: { roomName: room.name, roomImage: room.image }
  });
}
}