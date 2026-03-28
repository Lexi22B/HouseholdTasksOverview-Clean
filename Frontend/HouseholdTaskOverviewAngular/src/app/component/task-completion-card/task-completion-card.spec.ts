import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskCompletionCard } from './task-completion-card';

describe('TaskCompletionCard', () => {
  let component: TaskCompletionCard;
  let fixture: ComponentFixture<TaskCompletionCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskCompletionCard],
    }).compileComponents();

    fixture = TestBed.createComponent(TaskCompletionCard);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
