import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HousemateList } from './housemate-list';

describe('HousemateList', () => {
  let component: HousemateList;
  let fixture: ComponentFixture<HousemateList>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HousemateList],
    }).compileComponents();

    fixture = TestBed.createComponent(HousemateList);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
