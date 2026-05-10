import { Component, Input, Output, EventEmitter, CUSTOM_ELEMENTS_SCHEMA, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-edit-profile-popup',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './edit-profile-popup.html',
  styleUrl: './edit-profile-popup.css',
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})

export class EditProfilePopup implements OnChanges {
  @Input() isVisible: boolean = false;
  @Input() housemateData: any = null; // <-- Catches the data from home.html
  @Output() close = new EventEmitter<void>();
  @Output() save = new EventEmitter<any>();

  nickname: string = '';
  currentStatus: 'Active' | 'Inactive' = 'Active'; 
  
  // Dropdown Logic
  isDropdownOpen: boolean = false;
  
  // We will use a dummy array of 6 numbers to generate the 6 image slots. 
  // Later, you can replace these with actual image URLs!
  availableAvatars: number[] = [1, 2, 3, 4, 5, 6];
  selectedAvatarId: number = 1; // Default selected avatar

   // This Angular function runs automatically whenever housemateData arrives!
   ngOnChanges(changes: SimpleChanges) {
    if (changes['housemateData']) {
      if (this.housemateData) {
        this.nickname = this.housemateData.name;
        this.currentStatus = this.housemateData.status;
        this.selectedAvatarId = this.housemateData.avatarId || 1; // <-- Catch avatar ID!
      } else {
        this.nickname = '';
        this.currentStatus = 'Active';
        this.selectedAvatarId = 1;
      }
    }
  }

   // Used to update the nickname when typing
  onNicknameChange(event: any) {
    this.nickname = event.target.value;
  }

  closePopup() {
    this.isVisible = false;
    this.isDropdownOpen = false; // reset dropdown
    this.close.emit();
  }

  setStatus(status: 'Active' | 'Inactive') {
    this.currentStatus = status;
  }

  toggleDropdown() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  selectAvatar(id: number) {
    this.selectedAvatarId = id;
    this.isDropdownOpen = false; // Close menu after picking
  }

  onDone() {
    // Send the packaged data back to home.ts!
    this.save.emit({
      id: this.housemateData ? this.housemateData.id : null,
      name: this.nickname,
      status: this.currentStatus,
      avatarId: this.selectedAvatarId
    });
    this.closePopup();
  }
  
}