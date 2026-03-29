import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Housemate } from '../../Interfaces/model/housemate';

@Injectable({ providedIn: 'root' })
export class HousemateService {
  baseUrl: string = 'http://localhost:<YOUR_PORT>/api';

  constructor(private http: HttpClient) { }

  getAll(): Observable<Housemate[]> {
    return this.http.get<Housemate[]>(`${this.baseUrl}/housemates`);
  }

  getById(id: number): Observable<Housemate> {
    return this.http.get<Housemate>(`${this.baseUrl}/housemates/${id}`);
  }

  create(housemate: Housemate): Observable<any> {
    return this.http.post(`${this.baseUrl}/housemates`, housemate);
  }

  update(housemate: Housemate): Observable<any> {
    return this.http.put(`${this.baseUrl}/housemates`, housemate);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/housemates/${id}`);
  }
}
