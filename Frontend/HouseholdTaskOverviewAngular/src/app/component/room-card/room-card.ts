import { Component, Input } from '@angular/core';
import { Room } from '../../model/room';
import { RoomService } from '../../services/room-service';

@Component({
  standalone: true,
  selector: 'app-room-card',
  templateUrl: './room-card.html',
  styleUrl: './room-card.css'
})
export class RoomCard {
  @Input() room!: Room;

  constructor(private roomService: RoomService) { }

  delete(): void {
    this.roomService.delete(this.room.id).subscribe();
  }
}