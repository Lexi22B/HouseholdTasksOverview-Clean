import { Component, OnInit } from '@angular/core';
import { RoomService } from '../../services/room-service';
import { Room } from '../../model/room';
import { RoomCard } from '../room-card/room-card';

@Component({
  standalone: true,
  selector: 'app-room-list',
  templateUrl: './room-list.html',
  styleUrl: './room-list.css',
  imports: [RoomCard]
})
export class RoomList implements OnInit {
  rooms: Room[] = [];

  constructor(private roomService: RoomService) { }

  ngOnInit(): void {
    this.roomService.getAll().subscribe(data => {
      this.rooms = data;
    });
  }
}