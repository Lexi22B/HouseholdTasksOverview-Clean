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
    // If the popup is being opened OR data is changing
    if (changes['housemateData'] || changes['isVisible']) {
      if (this.housemateData) {
        // We are EDITING
        this.nickname = this.housemateData.name;
        this.currentStatus = this.housemateData.isActive ? 'Active' : 'Inactive';
        this.selectedAvatarId = this.housemateData.avatarId || 1;
      } else {
        // We are CREATING NEW - Force everything to empty/default
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
  // Package the UI input into a data object
  const dataToSave = {
    id: this.housemateData ? this.housemateData.id : null,
    name: this.nickname,
    status: this.currentStatus,
    avatarId: this.selectedAvatarId
  };

  // Emit the data so home.ts can send it to the C# backend
  this.save.emit(dataToSave); 
  
  this.closePopup();
  }

}