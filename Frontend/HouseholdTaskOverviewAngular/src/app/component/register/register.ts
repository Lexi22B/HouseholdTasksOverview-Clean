import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HouseholdService } from '../../services/household-service';
import { Router } from '@angular/router';
import { Household } from '../../model/household';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './register.html',
  styleUrl: './register.css'
})
export class RegisterComponent {

  houseCode: string = '';
  password: string = '';
  confirmPassword: string = '';

  constructor(
    private householdService: HouseholdService,
    private router: Router
  ) {}

  onCreateAccount(): void {

    if (this.password.length < 8) {
      console.log('Password too short');
      return;
    }

    if (this.password !== this.confirmPassword) {
      console.log('Passwords do not match');
      return;
    }

    const newHousehold: Household = {
      address: this.houseCode,
      houseCode: this.houseCode,
      passwordHash: this.password
    };

    this.householdService.create(newHousehold).subscribe({
      next: () => {
        console.log('Household created successfully');
        this.router.navigate(['/']);
      },
      error: (err) => {
        console.error('Error creating household', err);
      }
    });
  }
}