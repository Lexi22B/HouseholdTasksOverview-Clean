import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Room } from '../model/room';
import { environment } from '../../environments/environment';

@Injectable({ providedIn: 'root' })
export class RoomService {
  baseUrl: string = environment.apiUrl;

  constructor(private http: HttpClient) { }

  getAll(): Observable<Room[]> {
    return this.http.get<Room[]>(`${this.baseUrl}/room`);
  }

  getById(id: number): Observable<Room> {
    return this.http.get<Room>(`${this.baseUrl}/room/${id}`);
  }

  create(room: Room): Observable<any> {
    return this.http.post(`${this.baseUrl}/room`, room);
  }

  update(room: Room): Observable<any> {
    return this.http.put(`${this.baseUrl}/room`, room);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/room/${id}`);
  }
}
