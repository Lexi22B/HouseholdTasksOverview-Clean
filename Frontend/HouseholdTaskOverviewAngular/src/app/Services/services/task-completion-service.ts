import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { TaskCompletion } from '../../Interfaces/model/task-completion';

@Injectable({ providedIn: 'root' })
export class TaskCompletionService {
  baseUrl: string = 'http://localhost:<YOUR_PORT>/api';

  constructor(private http: HttpClient) { }

  getAll(): Observable<TaskCompletion[]> {
    return this.http.get<TaskCompletion[]>(`${this.baseUrl}/taskcompletions`);
  }

  getById(id: number): Observable<TaskCompletion> {
    return this.http.get<TaskCompletion>(`${this.baseUrl}/taskcompletions/${id}`);
  }

  create(taskcompletion: TaskCompletion): Observable<any> {
    return this.http.post(`${this.baseUrl}/taskcompletions`, taskcompletion);
  }

  update(taskcompletion: TaskCompletion): Observable<any> {
    return this.http.put(`${this.baseUrl}/taskcompletions`, taskcompletion);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/taskcompletions/${id}`);
  }
}
