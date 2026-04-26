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

  rooms = [
    { id: 1, image: 'assets/room1.png' },
    { id: 2, image: 'assets/room2.png' },
  ];

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

  openRoom(id: number) {
    this.router.navigate(['/room', id]);
  }
}