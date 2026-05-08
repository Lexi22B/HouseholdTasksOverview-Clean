import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { RoomService } from '../../services/room-service';
import { HouseholdService } from '../../services/household-service';
import { Room } from '../../model/room';
import { Household } from '../../model/household';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class HomeComponent implements OnInit {

  rooms: Room[] = [];

  // Add room popup
  showPopup = false;

  // House profile popup
  showHouseProfilePopup = false;
  household: Household | null = null;
  houseProfileError: string = '';

  // Change password form inside house profile popup
  showChangePasswordForm = false;
  newPassword: string = '';
  confirmNewPassword: string = '';
  passwordChangeError: string = '';
  passwordChangeSuccess: string = '';

  newRoom = {
    name: '',
    selectedImage: 'assets/rooms/room1.png'
  };

  roomImageOptions = [
    'assets/rooms/room1.png',
    'assets/rooms/room2.png',
    'assets/rooms/room3.png'
  ];

  constructor(
    private router: Router,
    private roomService: RoomService,
    private householdService: HouseholdService
  ) { }

  ngOnInit() {
    this.loadRooms();
    this.loadHousehold();
  }

  loadRooms() {
    const householdId = Number(localStorage.getItem('householdId'));

    this.roomService.getAll().subscribe(rooms => {
      this.rooms = rooms.filter(r => r.householdId === householdId);
    });
  }

  loadHousehold() {
    const householdId = Number(localStorage.getItem('householdId'));

    if (!householdId) {
      this.houseProfileError = 'No household is currently logged in.';
      return;
    }

    this.householdService.getById(householdId).subscribe({
      next: (household) => {
        this.household = household;
        this.houseProfileError = '';
      },
      error: (err) => {
        console.error('Could not load household', err);
        this.houseProfileError = 'Could not load house profile.';
      }
    });
  }

  openHouseProfilePopup() {
    this.loadHousehold();
    this.showHouseProfilePopup = true;

    this.showChangePasswordForm = false;
    this.newPassword = '';
    this.confirmNewPassword = '';
    this.passwordChangeError = '';
    this.passwordChangeSuccess = '';
  }

  closeHouseProfilePopup() {
    this.showHouseProfilePopup = false;

    this.showChangePasswordForm = false;
    this.newPassword = '';
    this.confirmNewPassword = '';
    this.passwordChangeError = '';
    this.passwordChangeSuccess = '';
  }

  openChangePasswordForm() {
    this.showChangePasswordForm = true;
    this.passwordChangeError = '';
    this.passwordChangeSuccess = '';
  }

saveNewPassword() {
  this.passwordChangeError = '';
  this.passwordChangeSuccess = '';

  if (this.newPassword.length < 8) {
    this.passwordChangeError = 'Please include at least 8 characters.';
    return;
  }

  if (this.newPassword !== this.confirmNewPassword) {
    this.passwordChangeError = 'Passwords do not match.';
    return;
  }

  const householdId = Number(localStorage.getItem('householdId'));

  if (!householdId) {
    this.passwordChangeError = 'No household is currently logged in.';
    return;
  }

  this.householdService.changePassword(householdId, this.newPassword).subscribe({
    next: () => {
      this.passwordChangeSuccess = 'Password updated successfully.';
      this.newPassword = '';
      this.confirmNewPassword = '';
      this.showChangePasswordForm = false;
    },
    error: (err) => {
      console.error('Password update failed', err);
      this.passwordChangeError = 'Could not update password. Try again.';
    }
  });
}

  goToHouseProfile() {
    this.openHouseProfilePopup();
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

    const householdId = Number(localStorage.getItem('householdId'));

    const room: Room = {
      id: 0,
      householdId: householdId,
      roomName: this.newRoom.name
    };

    this.roomService.create(room).subscribe((newId: number) => {
      this.closePopup();
      this.router.navigate(['/room', householdId, newId], {
        state: { roomName: this.newRoom.name }
      });
    });
  }

  deleteRoom(room: Room) {
    this.roomService.delete(room.id).subscribe(() => {
      this.loadRooms();
    });
  }

  openRoom(room: Room) {
    this.router.navigate(['/room', room.householdId, room.id], {
      state: { roomName: room.roomName }
    });
  }
}