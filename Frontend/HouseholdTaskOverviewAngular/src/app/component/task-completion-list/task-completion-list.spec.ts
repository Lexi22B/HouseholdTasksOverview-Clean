import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskCompletionList } from './task-completion-list';

describe('TaskCompletionList', () => {
  let component: TaskCompletionList;
  let fixture: ComponentFixture<TaskCompletionList>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskCompletionList],
    }).compileComponents();

    fixture = TestBed.createComponent(TaskCompletionList);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
