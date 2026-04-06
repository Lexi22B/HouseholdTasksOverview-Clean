import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Task } from '../model/task';

@Injectable({ providedIn: 'root' })
export class TaskService {
  baseUrl: string = 'http://localhost:<YOUR_PORT>/api';

  constructor(private http: HttpClient) { }

  getAll(): Observable<Task[]> {
    return this.http.get<Task[]>(`${this.baseUrl}/tasks`);
  }

  getById(id: number): Observable<Task> {
    return this.http.get<Task>(`${this.baseUrl}/tasks/${id}`);
  }

  create(task: Task): Observable<any> {
    return this.http.post(`${this.baseUrl}/tasks`, task);
  }

  update(task: Task): Observable<any> {
    return this.http.put(`${this.baseUrl}/tasks`, task);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/tasks/${id}`);
  }
}
