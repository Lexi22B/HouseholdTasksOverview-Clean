import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HousematesPopup } from './housemates-popup';

describe('HousematesPopup', () => {
  let component: HousematesPopup;
  let fixture: ComponentFixture<HousematesPopup>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HousematesPopup],
    }).compileComponents();

    fixture = TestBed.createComponent(HousematesPopup);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
