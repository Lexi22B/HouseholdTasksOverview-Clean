import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';

interface DifficultyLevel {
  id: number;
  name: string;
}

interface PriorityLevel {
  id: number;
  name: string;
}

interface DurationLevel {
  id: number;
  minutes: number;
}

interface Housemate {
  id: number;
  name: string;
  householdId: number;
}

interface Task {
  id: number;
  householdId: number;
  roomId: number;
  title: string;
  difficultyLevelId: number;
  priorityLevelId: number;
  durationLevelId: number;
}

interface TaskAssignment {
  id: number;
  taskId: number;
  housemateId: number;
}

@Component({
  standalone: true,
  selector: 'app-create-task',
  templateUrl: './create-task.html',
  styleUrl: './create-task.css',
  imports: [CommonModule, FormsModule]
})
export class CreateTaskComponent implements OnInit {
  private baseUrl = 'http://localhost:5122/api';

  roomId!: number;
  householdId!: number;

  // Form state
  taskTitle = '';
  selectedPriority: number | null = null;   // 1=Low, 2=Medium, 3=High
  selectedDifficulty: number | null = null; // 1=Easy, 2=Medium, 3=Hard
  selectedDuration: number | null = null;   // 1=15min, 2=30min, 3=60min
  selectedHousemate: Housemate | null = null;

  searchName = '';
  allHousemates: Housemate[] = [];
  filteredHousemates: Housemate[] = [];

  submitting = false;
  errorMsg = '';

  difficultyOptions: DifficultyLevel[] = [];
  priorityOptions: PriorityLevel[] = [];
  durationOptions: DurationLevel[] = [];


  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private http: HttpClient
  ) { }

  ngOnInit(): void {
    this.householdId = Number(this.route.snapshot.paramMap.get('householdId'));
    this.roomId = Number(this.route.snapshot.paramMap.get('roomId'));

    this.http.get<Housemate[]>(`${this.baseUrl}/Housemates`).subscribe({
      next: data => this.allHousemates = data,
      error: () => { }
    });

    this.http.get<DifficultyLevel[]>(`${this.baseUrl}/DifficultyLevels`).subscribe({
      next: data => this.difficultyOptions = data,
      error: () => { }
    });

    this.http.get<PriorityLevel[]>(`${this.baseUrl}/PriorityLevels`).subscribe({
      next: data => this.priorityOptions = data,
      error: () => { }
    });

    this.http.get<DurationLevel[]>(`${this.baseUrl}/DurationLevels`).subscribe({
      next: data => this.durationOptions = data,
      error: () => { }
    });
  }

  // ── Priority ──
  selectPriority(value: number) {
    this.selectedPriority = this.selectedPriority === value ? null : value;
  }

  getPriorityColor(value: number): string {
    const colors: { [key: number]: string } = {
      1: '#ef4444',
      2: '#f59e0b',
      3: '#22c55e'
    };
    return colors[value] || '#ddd';
  }

  // ── Duration ──
  selectDuration(value: number) {
    this.selectedDuration = this.selectedDuration === value ? null : value;
  }

  // ── Difficulty ──
  selectDifficulty(value: number) {
    this.selectedDifficulty = this.selectedDifficulty === value ? null : value;
  }

  // ── Housemate search ──
  filterHousemates() {
    const q = this.searchName.toLowerCase().trim();
    this.filteredHousemates = q
      ? this.allHousemates.filter(h => h.name.toLowerCase().includes(q))
      : [];
    // Clear selection if text changed
    if (this.selectedHousemate && !this.selectedHousemate.name.toLowerCase().includes(q)) {
      this.selectedHousemate = null;
    }
  }

  selectHousemate(h: Housemate) {
    this.selectedHousemate = h;
    this.searchName = h.name;
    this.filteredHousemates = [];
  }

  // ── Validation ──
  isValid(): boolean {
    return (
      this.taskTitle.trim().length > 0 &&
      this.selectedPriority !== null &&
      this.selectedDifficulty !== null &&
      this.selectedDuration !== null &&
      this.selectedHousemate !== null
    );
  }



  // ── Submit: POST Task → POST TaskAssignment ──
  submit() {
    if (!this.isValid() || this.submitting) return;

    this.submitting = true;
    this.errorMsg = '';


    const newTask = {
      id: 0,
      householdId: this.householdId,
      roomId: this.roomId,
      title: this.taskTitle.trim(),
      difficulty: this.selectedDifficulty!,
      priority: this.selectedPriority!,
      estimatedDurationMinutes: this.selectedDuration!
    };

    // Step 1: Create the task
    this.http.post<any>(`${this.baseUrl}/Tasks`, newTask).subscribe({
      next: (createdTask) => {
        // Step 2: Assign it
        console.log('Created task response:', createdTask);
        const taskId = createdTask?.id ?? createdTask?.Id;
        console.log('Task ID extracted:', taskId);
        const assignment = {
          id: 0,
          taskId: taskId,
          housemateId: this.selectedHousemate!.id
        };

        this.http.post(`${this.baseUrl}/TaskAssignments`, assignment).subscribe({
          next: () => {
            this.submitting = false;
            this.goBack();
          },
          error: (err) => {
            this.submitting = false;
            this.errorMsg = 'Task created but assignment failed. Check the console.';
            console.error('Assignment POST failed:', err);
          }
        });
      },
      error: (err) => {
        this.submitting = false;
        this.errorMsg = 'Could not create task. Check the console.';
        console.error('Task POST failed:', err);
      }
    });
  }

  goBack() {
    this.router.navigate(['/room', this.householdId, this.roomId]);
  }
}