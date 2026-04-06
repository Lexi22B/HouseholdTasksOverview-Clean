import { TestBed } from '@angular/core/testing';

import { TaskCompletionService } from './task-completion-service';

describe('TaskCompletionService', () => {
  let service: TaskCompletionService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TaskCompletionService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
