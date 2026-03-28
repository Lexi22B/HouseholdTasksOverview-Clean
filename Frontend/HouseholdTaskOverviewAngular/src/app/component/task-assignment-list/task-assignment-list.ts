import { Component, OnInit } from '@angular/core';
import { TaskAssignmentService } from '../../Services/services/task-assignment-service';
import { TaskAssignment } from '../../Interfaces/model/task-assignment';
import { TaskAssignmentCard } from '../task-assignment-card/task-assignment-card';

@Component({
  selector: 'app-task-assignment-list',
  imports: [TaskAssignmentCard],
  templateUrl: './task-assignment-list.html',
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
