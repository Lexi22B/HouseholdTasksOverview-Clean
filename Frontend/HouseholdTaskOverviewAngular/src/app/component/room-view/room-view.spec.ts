import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RoomViewComponent } from './room-view'; // <-- Updated to RoomViewComponent

describe('RoomViewComponent', () => {
  let component: RoomViewComponent; // <-- Updated
  let fixture: ComponentFixture<RoomViewComponent>; // <-- Updated

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RoomViewComponent], // <-- Updated
    }).compileComponents();

    fixture = TestBed.createComponent(RoomViewComponent); // <-- Updated
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});