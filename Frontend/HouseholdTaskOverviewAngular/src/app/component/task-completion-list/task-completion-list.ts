import { Component, OnInit } from '@angular/core';
import { TaskCompletionService } from '../../services/task-completion-service';
import { TaskCompletion } from '../../model/task-completion';
import { TaskCompletionCard } from '../task-completion-card/task-completion-card';

@Component({
  standalone: true,
  selector: 'app-task-completion-list',
  templateUrl: './task-completion-list.html',
  styleUrl: './task-completion-list.css',
  imports: [TaskCompletionCard]
})
export class TaskCompletionList implements OnInit {
  completions: TaskCompletion[] = [];

  constructor(private taskCompletionService: TaskCompletionService) { }

  ngOnInit(): void {
    this.taskCompletionService.getAll().subscribe(data => {
      this.completions = data;
    });
  }
}