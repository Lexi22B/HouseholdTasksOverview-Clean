import { Component, OnInit } from '@angular/core';
import { HousemateService } from '../../services/housemate-service';
import { Housemate } from '../../model/housemate';
import { HousemateCard } from '../housemate-card/housemate-card';

@Component({
  standalone: true,
  selector: 'app-housemate-list',
  templateUrl: './housemate-list.html',
  styleUrl: './housemate-list.css',
  imports: [HousemateCard]
})
export class HousemateList implements OnInit {
  housemates: Housemate[] = [];

  constructor(private housemateService: HousemateService) { }

  ngOnInit(): void {
    this.housemateService.getAll().subscribe(data => {
      this.housemates = data;
    });
  }
}