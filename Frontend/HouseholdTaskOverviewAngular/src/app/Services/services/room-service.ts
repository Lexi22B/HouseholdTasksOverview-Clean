import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Room } from '../../Interfaces/model/room';

@Injectable({ providedIn: 'root' })
export class TaskAssignmentService {
  baseUrl: string = 'http://localhost:<YOUR_PORT>/api';

  constructor(private http: HttpClient) { }

  getAll(): Observable<Room[]> {
    return this.http.get<TaskAssignment[]>(`${this.baseUrl}/taskassignments`);
  }

  getById(id: number): Observable<TaskAssignment> {
    return this.http.get<TaskAssignment>(`${this.baseUrl}/taskassignments/${id}`);
  }

  create(assignment: TaskAssignment): Observable<any> {
    return this.http.post(`${this.baseUrl}/taskassignments`, assignment);
  }

  update(assignment: TaskAssignment): Observable<any> {
    return this.http.put(`${this.baseUrl}/taskassignments`, assignment);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/taskassignments/${id}`);
  }
}

