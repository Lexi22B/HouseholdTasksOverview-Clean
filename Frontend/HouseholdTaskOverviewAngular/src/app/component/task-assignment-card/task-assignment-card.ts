import { Component, Input } from '@angular/core';
import { TaskAssignment } from '../../model/task-assignment';
import { TaskAssignmentService } from '../../services/task-assignment-service';

@Component({
  standalone: true,
  selector: 'app-task-assignment-card',
  templateUrl: './task-assignment-card.html',
  styleUrl: './task-assignment-card.css'
})
export class TaskAssignmentCard {
  @Input() assignment!: TaskAssignment;

  constructor(private taskAssignmentService: TaskAssignmentService) { }

  delete(): void {
    this.taskAssignmentService.delete(this.assignment.id).subscribe();
  }
}