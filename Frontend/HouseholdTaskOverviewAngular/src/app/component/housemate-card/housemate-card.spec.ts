import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HousemateCard } from './housemate-card';

describe('HousemateCard', () => {
  let component: HousemateCard;
  let fixture: ComponentFixture<HousemateCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HousemateCard],
    }).compileComponents();

    fixture = TestBed.createComponent(HousemateCard);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
