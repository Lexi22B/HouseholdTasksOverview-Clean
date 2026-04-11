import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Household } from '../model/household';
import { environment } from '../../environments/environment';

@Injectable({ providedIn: 'root' })
export class HouseholdService {
  baseUrl: string = environment.apiUrl; //only this port number is changed, not the other baseURL

  constructor(private http: HttpClient) { }

  getAll(): Observable<Household[]> {
    return this.http.get<Household[]>(`${this.baseUrl}/households`);
  }

  getById(id: number): Observable<Household> {
    return this.http.get<Household>(`${this.baseUrl}/households/${id}`);
  }

  create(household: Household): Observable<any> {
    return this.http.post(`${this.baseUrl}/households`, household);
  }

  update(household: Household): Observable<any> {
    return this.http.put(`${this.baseUrl}/households`, household);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/households/${id}`);
  }
}
