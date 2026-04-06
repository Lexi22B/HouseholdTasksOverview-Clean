import { Component, Input } from '@angular/core';
import { Housemate } from '../../model/housemate';
import { HousemateService } from '../../services/housemate-service';

@Component({
  standalone: true,
  selector: 'app-housemate-card',
  templateUrl: './housemate-card.html',
  styleUrl: './housemate-card.css'
})
export class HousemateCard {
  @Input() housemate!: Housemate;

  constructor(private housemateService: HousemateService) { }

  delete(): void {
    this.housemateService.delete(this.housemate.id).subscribe();
  }
}
