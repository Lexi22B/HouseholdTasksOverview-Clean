import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { TaskService } from '../../services/task-service';
import { TaskAssignmentService } from '../../services/task-assignment-service';
import { TaskCompletionService } from '../../services/task-completion-service';
import { HousemateService } from '../../services/housemate-service';
import { Task } from '../../model/task';
import { TaskAssignment } from '../../model/task-assignment';
import { TaskCompletion } from '../../model/task-completion';
import { Housemate } from '../../model/housemate';

interface TaskWithStatus extends Task {
  assignment?: TaskAssignment;
  completion?: TaskCompletion;
  housemate?: Housemate;
}

@Component({
  selector: 'app-room-view',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './room-view.html',
  styleUrl: './room-view.css'
})
export class RoomViewComponent implements OnInit {

  roomId!: number;
  roomName: string = 'Room';
  roomImage: string = 'assets/rooms/default.png';
  tasks: TaskWithStatus[] = [];

  priorityLabels: { [key: number]: string } = {
    1: 'Low', 2: 'Medium', 3: 'High'
  };
  priorityColors: { [key: number]: string } = {
    1: '#1A6552', 2: '#f0a500', 3: '#e03000'
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private taskService: TaskService,
    private taskAssignmentService: TaskAssignmentService,
    private taskCompletionService: TaskCompletionService,
    private housemateService: HousemateService
  ) {}

  ngOnInit() {
    this.roomId = Number(this.route.snapshot.paramMap.get('id'));
    this.roomName = history.state?.roomName || 'Room';
    this.roomImage = history.state?.roomImage || 'assets/rooms/default.png';
    this.loadData();
  }

  loadData() {
    this.taskService.getAll().subscribe(allTasks => {
      const roomTasks = allTasks.filter(t => t.roomId === this.roomId && t.isActive);
      this.taskAssignmentService.getAll().subscribe(assignments => {
        this.taskCompletionService.getAll().subscribe(completions => {
          this.housemateService.getAll().subscribe(housemates => {
            this.tasks = roomTasks.map(task => {
              const assignment = assignments.find(a => a.taskId === task.id);
              const completion = assignment
                ? completions.find(c => c.assignmentId === assignment.id)
                : undefined;
              const housemate = assignment
                ? housemates.find(h => h.id === assignment.housemateId)
                : undefined;
              return { ...task, assignment, completion, housemate };
            });
          });
        });
      });
    });
  }

  get todoTasks(): TaskWithStatus[] {
    return this.tasks.filter(t => !t.completion);
  }

  get doneTasks(): TaskWithStatus[] {
    return this.tasks.filter(t => !!t.completion);
  }

 markDone(task: TaskWithStatus) {
  if (!task.assignment) return;
  const completion = {
    id: 0,
    assignmentId: task.assignment.id,
    completedAt: new Date().toISOString()
  };
  this.taskCompletionService.create(completion)
    .subscribe(() => this.loadData());
}

  markUndone(task: TaskWithStatus) {
    if (!task.completion) return;
    this.taskCompletionService.delete(task.completion.id)
      .subscribe(() => this.loadData());
  }

  deleteTask(task: TaskWithStatus) {
    // Delete completion first if exists
    const deleteCompletion = task.completion
      ? this.taskCompletionService.delete(task.completion.id)
      : null;

    const proceed = () => {
      // Delete assignment if exists
      const deleteAssignment = task.assignment
        ? this.taskAssignmentService.delete(task.assignment.id)
        : null;

      const deleteTaskFn = () => {
        this.taskService.delete(task.id).subscribe(() => this.loadData());
      };

      if (deleteAssignment) {
        deleteAssignment.subscribe(() => deleteTaskFn());
      } else {
        deleteTaskFn();
      }
    };

    if (deleteCompletion) {
      deleteCompletion.subscribe(() => proceed());
    } else {
      proceed();
    }
  }

  goToCreateTask() {
    this.router.navigate(['/create-task'], {
      state: { roomId: this.roomId, roomName: this.roomName }
    });
  }

  goBack() {
    this.router.navigate(['/home']);
  }

  getPriorityLabel(p?: number): string {
    return p ? this.priorityLabels[p] || 'Low' : 'Low';
  }

  getPriorityColor(p?: number): string {
    return p ? this.priorityColors[p] || '#1A6552' : '#1A6552';
  }

  getEffortLabel(d?: number): string {
    const labels: { [k: number]: string } = { 1: 'Easy', 2: 'Moderate', 3: 'Difficult' };
    return d ? labels[d] || 'Easy' : 'Easy';
  }

  getDurationLabel(d?: number): string {
    const labels: { [k: number]: string } = { 1: '15 min', 2: '30 min', 3: '60 min' };
    return d ? labels[d] || '' : '';
  }

  
}