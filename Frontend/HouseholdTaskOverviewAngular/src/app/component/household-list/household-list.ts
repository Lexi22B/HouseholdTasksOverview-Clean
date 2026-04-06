import { Component, OnInit } from '@angular/core';
import { HouseholdService } from '../../services/household-service';
import { Household } from '../../model/household';
import { HouseholdCard } from '../household-card/household-card';

@Component({
  standalone: true,
  selector: 'app-household-list',
  templateUrl: './household-list.html',
  styleUrl: './household-list.css',
  imports: [HouseholdCard]
})
export class HouseholdList implements OnInit {
  households: Household[] = [];

  constructor(private householdService: HouseholdService) { }

  ngOnInit(): void {
    this.householdService.getAll().subscribe(data => {
      this.households = data;
    });
  }
}