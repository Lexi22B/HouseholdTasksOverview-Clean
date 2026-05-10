import { Component, Input, Output, EventEmitter, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { CommonModule } from '@angular/common';

// We define what a "Housemate" looks like so Angular knows what data to expect
interface Housemate {
  id: number;
  name: string;
  status: 'Active' | 'Inactive';
}

@Component({
  selector: 'app-housemates-popup',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './housemates-popup.html',
  styleUrl: './housemates-popup.css',
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class HousematesPopup {
  @Input() isVisible: boolean = false; 
  @Output() close = new EventEmitter<void>();
  @Output() openAddProfile = new EventEmitter<void>();
  @Output() editProfile = new EventEmitter<any>();
  @Input() housematesList: any[] = []; 
  @Output() deleteProfile = new EventEmitter<number>();

  selectedCardId: number | null = 1; // Tracks which card has the orange border

  closePopup() {
    this.isVisible = false;
    this.close.emit();
  }

  selectCard(person: any) {
    this.selectedCardId = person.id;
    this.editProfile.emit(person); // This tells the Home page to open the edit screen with this user's data!
  }

  deleteHousemate(id: number, event: Event) {
   event.stopPropagation(); 
    this.deleteProfile.emit(id); // Tells Home to delete them!
    
    console.log("Deleted housemate ID:", id);
  }

  onAddHousemate() {
    this.openAddProfile.emit();
    
  }
}