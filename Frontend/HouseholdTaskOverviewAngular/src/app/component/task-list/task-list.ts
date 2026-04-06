import { Component, OnInit } from '@angular/core';
import { TaskService } from '../../services/task-service';
import { Task } from '../../model/task';
import { TaskCard } from '../task-card/task-card';

@Component({
  standalone: true,
  selector: 'app-task-list',
  templateUrl: './task-list.html',
  styleUrl: './task-list.css',
  imports: [TaskCard]
})
export class TaskList implements OnInit {
  tasks: Task[] = [];

  constructor(private taskService: TaskService) { }

  ngOnInit(): void {
    this.taskService.getAll().subscribe(data => {
      this.tasks = data;
    });
  }
}