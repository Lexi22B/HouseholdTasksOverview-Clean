import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { TaskService } from '../../services/task-service';
import { TaskAssignmentService } from '../../services/task-assignment-service';
import { HousemateService } from '../../services/housemate-service';
import { Task } from '../../model/task';
import { TaskAssignment } from '../../model/task-assignment';
import { Housemate } from '../../model/housemate';

@Component({
  selector: 'app-create-task',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './create-task.html',
  styleUrl: './create-task.css'
})
export class CreateTaskComponent implements OnInit {

  roomId!: number;
  roomName: string = 'Room';
  housemates: Housemate[] = [];
  filteredHousemates: Housemate[] = [];
  searchName: string = '';

  effortOptions = [
    { label: 'Easy', value: 1 },
    { label: 'Moderate', value: 2 },
    { label: 'Difficult', value: 3 }
  ];

  durationOptions = [
    { label: '15 min', value: 1 },
    { label: '30 min', value: 2 },
    { label: '60 min', value: 3 }
  ];

  task = {
    title: '',
    priority: null as number | null,
    difficulty: 1,
    estimatedDurationMinutes: null as number | null,
    housemateId: null as number | null,
    housemateName: ''
  };

  constructor(
    private router: Router,
    private taskService: TaskService,
    private taskAssignmentService: TaskAssignmentService,
    private housemateService: HousemateService
  ) {}

  ngOnInit() {
    this.roomId = history.state?.roomId;
    this.roomName = history.state?.roomName || 'Room';
    this.housemateService.getAll().subscribe(h => {
      this.housemates = h.filter(hm => hm.isActive);
      this.filteredHousemates = this.housemates;
    });
  }

  filterHousemates() {
    this.filteredHousemates = this.housemates.filter(h =>
      h.name.toLowerCase().includes(this.searchName.toLowerCase())
    );
  }

  selectHousemate(h: Housemate) {
    this.task.housemateId = h.id;
    this.task.housemateName = h.name;
    this.searchName = h.name;
    this.filteredHousemates = [];
  }

  selectDuration(value: number) {
    this.task.estimatedDurationMinutes = value;
  }

  selectPriority(p: number) {
    this.task.priority = p;
  }

  isValid(): boolean {
    return !!this.task.title && !!this.task.priority &&
           !!this.task.estimatedDurationMinutes && !!this.task.housemateId;
  }

  submit() {
    if (!this.isValid()) return;

    const newTask: Task = {
      id: 0,
      householdId: 1,
      roomId: this.roomId,
      title: this.task.title,
      priority: this.task.priority!,
      difficulty: this.task.difficulty,
      estimatedDurationMinutes: this.task.estimatedDurationMinutes!,
      isActive: true,
      createdAt: new Date()
    };

    this.taskService.create(newTask).subscribe(() => {
      this.taskService.getAll().subscribe(tasks => {
        const created = tasks
          .filter(t => t.roomId === this.roomId && t.title === this.task.title)
          .sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())[0];

        if (created && this.task.housemateId) {
          const assignment: TaskAssignment = {
            id: 0,
            taskId: created.id,
            housemateId: this.task.housemateId!,
            status: 'pending'
          };

          this.taskAssignmentService.create(assignment).subscribe(() => {
            this.router.navigate(['/room', this.roomId], {
              state: { roomName: this.roomName }
            });
          });
        }
      });
    });
  }

  goBack() {
    this.router.navigate(['/room', this.roomId], {
      state: { roomName: this.roomName }
    });
  }

  getPriorityLabel(p: number): string {
    const labels: { [k: number]: string } = { 1: 'Low', 2: 'Medium', 3: 'High' };
    return labels[p] || '';
  }

  getPriorityColor(p: number): string {
    const colors: { [k: number]: string } = {
      1: '#1A6552', 2: '#f0a500', 3: '#e85d4a'
    };
    return colors[p] || '#ccc';
  }
}