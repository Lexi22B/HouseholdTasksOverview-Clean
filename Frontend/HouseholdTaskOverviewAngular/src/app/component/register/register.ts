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

  //  needed for showing validation messages
  showErrors: boolean = false;

  constructor(
    private householdService: HouseholdService,
    private router: Router
  ) {}

  onCreateAccount(): void {

    // turn on validation messages
    this.showErrors = true;

    // password length check
    if (this.password.length < 8) {
      return;
    }

    // password match check
    if (this.password !== this.confirmPassword) {
      return;
    }

    // create object to send to backend
    const newHousehold: Household = {
      houseCode: this.houseCode,
      passwordHash: this.password
    };

    this.householdService.create(newHousehold).subscribe({
      next: () => {
    this.householdService.login(this.houseCode, this.password).subscribe({
    next: (household) => {
      localStorage.setItem('householdId', household.id!.toString());
      localStorage.setItem('houseCode', household.houseCode);
      this.router.navigate(['/home']);
    }
  });
},
      error: (err) => {
        console.error('Error creating household', err);
      }
    });
  }
}