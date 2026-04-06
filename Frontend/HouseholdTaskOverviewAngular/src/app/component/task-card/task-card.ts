import { Component, Input } from '@angular/core';
import { Task } from '../../model/task';
import { TaskService } from '../../services/task-service';

@Component({
  standalone: true,
  selector: 'app-task-card',
  templateUrl: './task-card.html',
  styleUrl: './task-card.css'
})
export class TaskCard {
  @Input() task!: Task;

  constructor(private taskService: TaskService) { }

  delete(): void {
    this.taskService.delete(this.task.id).subscribe();
  }
}