import { Component, Input } from '@angular/core';
import { Household } from '../../model/household';
import { HouseholdService } from '../../services/household-service';

@Component({
  standalone: true,
  selector: 'app-household-card',
  templateUrl: './household-card.html',
  styleUrl: './household-card.css'
})
export class HouseholdCard {
  @Input() household!: Household;

  constructor(private householdService: HouseholdService) {}

  deleteHousehold(): void {
    if (this.household.id === undefined) {
      return;
    }

    this.householdService.delete(this.household.id).subscribe({
      next: () => {
        console.log('Household deleted');
      },
      error: (err) => {
        console.error('Error deleting household', err);
      }
    });
  }
}