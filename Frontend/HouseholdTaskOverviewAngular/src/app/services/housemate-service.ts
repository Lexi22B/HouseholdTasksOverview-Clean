import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Housemate } from '../model/housemate';
import { environment } from '../../environments/environment';

@Injectable({ providedIn: 'root' })
export class HousemateService {
  baseUrl: string = environment.apiUrl;

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
