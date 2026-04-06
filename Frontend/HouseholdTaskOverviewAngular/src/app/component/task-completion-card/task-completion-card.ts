import { Component, Input } from '@angular/core';
import { TaskCompletion } from '../../model/task-completion';
import { TaskCompletionService } from '../../services/task-completion-service';

@Component({
  standalone: true,
  selector: 'app-task-completion-card',
  templateUrl: './task-completion-card.html',
  styleUrl: './task-completion-card.css'
})
export class TaskCompletionCard {
  @Input() completion!: TaskCompletion;

  constructor(private taskCompletionService: TaskCompletionService) { }

  delete(): void {
    this.taskCompletionService.delete(this.completion.id).subscribe();
  }
}