import { Component, OnInit } from '@angular/core';
import { TaskAssignmentService } from '../../services/task-assignment-service';
import { TaskAssignment } from '../../model/task-assignment';
import { TaskAssignmentCard } from '../task-assignment-card/task-assignment-card';

@Component({
  standalone: true,
  selector: 'app-task-assignment-list',
  templateUrl: './task-assignment-list.html',
  styleUrl: './task-assignment-list.css',
  imports: [TaskAssignmentCard]
})
export class TaskAssignmentList implements OnInit {
  assignments: TaskAssignment[] = [];

  constructor(private taskAssignmentService: TaskAssignmentService) { }

  ngOnInit(): void {
    this.taskAssignmentService.getAll().subscribe(data => {
      this.assignments = data;
    });
  }
}