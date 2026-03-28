import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskAssignmentCard } from './task-assignment-card';

describe('TaskAssignmentCard', () => {
  let component: TaskAssignmentCard;
  let fixture: ComponentFixture<TaskAssignmentCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskAssignmentCard],
    }).compileComponents();

    fixture = TestBed.createComponent(TaskAssignmentCard);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
