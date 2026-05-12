import { Component, OnInit, CUSTOM_ELEMENTS_SCHEMA} from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';

// --- Services ---
import { RoomService } from '../../services/room-service';
import { HouseholdService } from '../../services/household-service';
import { HousemateService } from '../../services/housemate-service'; // <-- Added Housemate Service

// --- Models ---
import { Room } from '../../model/room';
import { Household } from '../../model/household';
import { Housemate } from '../../model/housemate'; // <-- Added Housemate Model

// --- Popups ---
import { HousematesPopup } from '../housemates-popup/housemates-popup';
import { EditProfilePopup } from '../edit-profile-popup/edit-profile-popup';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, FormsModule, HousematesPopup, EditProfilePopup],
  templateUrl: './home.html',
  styleUrl: './home.css',
  schemas: [CUSTOM_ELEMENTS_SCHEMA] // custom icons
})
export class HomeComponent implements OnInit {

  rooms: Room[] = [];

  // Add room popup
  showPopup = false;

  // --- Housemates and Edit Profile Popups ---
  isHousematesListOpen: boolean = false;
  isEditProfileOpen: boolean = false;
  selectedHousemate: any = null; // <-- function to hold the user data
  
  // Replaced the dummy data with an empty array. The database fills this now!
  housematesList: Housemate[] = []; 

  
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
    '/assets/rooms/room1.png',
    '/assets/rooms/room2.png',
    '/assets/rooms/room3.png',
    '/assets/rooms/room4.png', /* Add the rest of your PNG names here! */
    '/assets/rooms/room5.png',
    '/assets/rooms/room6.png'
  ];

  // Injected the housemateService into the constructor!
  constructor(
    private router: Router,
    private roomService: RoomService,
    private householdService: HouseholdService,
    private housemateService: HousemateService 
  ) { }

  ngOnInit() {
    this.loadRooms();
    this.loadHousehold();
    this.loadHousemates(); // <-- Tells Angular to grab housemates when the page loads
  }

  // --- NEW FUNCTION: Loads housemates from the PostgreSQL Database ---
 loadHousemates() {
  const householdId = Number(localStorage.getItem('householdId'));

  this.housemateService.getAll().subscribe({
    next: (data) => {
      // Map through the data to add the 'status' string based on 'isActive'
      this.housematesList = data
        .filter(h => h.householdId === householdId)
        .map(h => ({
          ...h,
          status: h.isActive ? 'Active' : 'Inactive'
        }));
    },
    error: (err) => console.error("Failed to load housemates", err)
  });
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

    // We use 'as any' here assuming your Room interface in Angular doesn't have imageUrl yet
    const room: any = {
      id: 0,
      householdId: householdId,
      roomName: this.newRoom.name,
      imageUrl: this.newRoom.selectedImage // <-- We are now saving the image path!
    };

    this.roomService.create(room).subscribe((newId: number) => {
      this.closePopup();
      this.loadRooms(); // Refresh the home page to show the new card!
    });
  }

  deleteRoom(room: Room) {
    this.roomService.delete(room.id).subscribe(() => {
      this.loadRooms();
    });
  }

 openRoom(room: Room) {
    this.router.navigate(['/room', room.householdId, room.id], {
      state: { 
        roomName: room.roomName,
        roomImage: (room as any).imageUrl // <-- ADD THIS LINE!
      }
    });
  }

  // --- HOUSEMATE POPUP LOGIC ---

  openHousematesList() {
    this.isHousematesListOpen = true;
    this.isEditProfileOpen = false;
  }

  openEditProfile(housemateData: any = null) {
    // Convert boolean back to the 'Active'/'Inactive' string the popup UI expects
    if (housemateData) {
       housemateData.status = housemateData.isActive ? 'Active' : 'Inactive';
    }
    this.selectedHousemate = housemateData;
    this.isEditProfileOpen = true;
    this.isHousematesListOpen = false;
  }

  closeAllPopups() {
    this.isHousematesListOpen = false;
    this.isEditProfileOpen = false;
  }

  // Receives data from the Edit Popup when "Done" is clicked, saves to DB
  saveHousemateData(data: any) {
    const householdId = Number(localStorage.getItem('householdId'));

    const newHousemate: Housemate = {
      id: data.id ? data.id : 0,
      householdId: householdId,
      name: data.name,
      isActive: data.status === 'Active',
      avatarId: data.avatarId
    };

    if (newHousemate.id) {
      // Editing an existing person (Calls PUT)
      this.housemateService.update(newHousemate).subscribe({
        next: () => this.loadHousemates(),
        error: (err) => console.error("Update failed", err)
      });
    } else {
      // Adding a brand new person (Calls POST)
      this.housemateService.create(newHousemate).subscribe({
        next: () => this.loadHousemates(),
        error: (err) => console.error("Create failed", err)
      });
    }

    this.openHousematesList(); // Go back to the list view
  }

  // Deletes a user from the DB and the list
  deleteHousemateFromList(id: number) {
    this.housemateService.delete(id).subscribe(() => {
      this.loadHousemates(); // Refresh the list after deleting
    });
  }
  
}