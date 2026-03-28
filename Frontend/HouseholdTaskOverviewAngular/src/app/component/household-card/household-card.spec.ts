import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HouseholdCard } from './household-card';

describe('HouseholdCard', () => {
  let component: HouseholdCard;
  let fixture: ComponentFixture<HouseholdCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HouseholdCard],
    }).compileComponents();

    fixture = TestBed.createComponent(HouseholdCard);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
