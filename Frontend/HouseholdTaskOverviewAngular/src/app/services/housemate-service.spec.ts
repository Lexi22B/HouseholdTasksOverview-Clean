import { TestBed } from '@angular/core/testing';

import { HousemateService } from './housemate-service';

describe('HousemateService', () => {
  let service: HousemateService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HousemateService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
