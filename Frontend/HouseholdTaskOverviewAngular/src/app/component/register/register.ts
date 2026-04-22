import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './register.html',
  styleUrl: './register.css'
})
export class RegisterComponent {
  houseId: string = '';
  password: string = '';
  confirmPassword: string = '';

  onCreateAccount(): void {
    console.log('Registration form data:', {
      houseId: this.houseId,
      password: this.password,
      confirmPassword: this.confirmPassword
    });
  }
}