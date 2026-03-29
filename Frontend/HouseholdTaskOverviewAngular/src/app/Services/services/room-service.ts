import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Room } from '../../Interfaces/model/room';

@Injectable({ providedIn: 'root' })
export class RoomService {
  baseUrl: string = 'http://localhost:<YOUR_PORT>/api';

  constructor(private http: HttpClient) { }

  getAll(): Observable<Room[]> {
    return this.http.get<Room[]>(`${this.baseUrl}/rooms`);
  }

  getById(id: number): Observable<Room> {
    return this.http.get<Room>(`${this.baseUrl}/rooms/${id}`);
  }

  create(room: Room): Observable<any> {
    return this.http.post(`${this.baseUrl}/rooms`, room);
  }

  update(room: Room): Observable<any> {
    return this.http.put(`${this.baseUrl}/rooms`, room);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/rooms/${id}`);
  }
}
