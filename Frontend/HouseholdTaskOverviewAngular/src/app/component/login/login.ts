import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { HouseholdService } from '../../services/household-service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css'
})
export class LoginComponent {
  houseCode: string = '';
  password: string = '';
  showErrors: boolean = false;
  loginError: string = '';

  constructor(
    private householdService: HouseholdService,
    private router: Router
  ) {}

  onJoinHouse(): void {
    this.showErrors = true;
    this.loginError = '';

    if (!this.houseCode || !this.password) {
      return;
    }

    this.householdService.login(this.houseCode, this.password).subscribe({
      next: (household) => {
        console.log('Login successful', household);

        localStorage.setItem('householdId', household.id!.toString());
        localStorage.setItem('houseCode', household.houseCode);

        this.router.navigate(['/home']);
      },
      error: (err) => {
        console.error('Login failed', err);
        this.loginError = 'Invalid House ID or password. Try again.';
      }
    });
  }
}