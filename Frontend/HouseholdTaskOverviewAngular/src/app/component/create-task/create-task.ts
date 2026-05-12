import { Component, OnInit, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
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
  avatarId?: number;
}

interface Task {
  id: number;
  householdId: number;
  roomId: number;
  title: string;
  difficulty: number; // Updated
  priority: number;   // Updated
  estimatedDurationMinutes: number; // Updated
}

interface TaskAssignment {
  id: number;
  taskId: number;
  housemateId: number;
}

// Notice how the @Component sits perfectly on top of the export class now!
@Component({
  standalone: true,
  selector: 'app-create-task',
  templateUrl: './create-task.html',
  styleUrl: './create-task.css',
  imports: [CommonModule, FormsModule],
  schemas: [CUSTOM_ELEMENTS_SCHEMA] 
})
export class CreateTaskComponent implements OnInit {
  private baseUrl = 'http://localhost:5122/api';

  roomId!: number;
  householdId!: number;

  // <-- For fetching room image -->
  roomName: string = '';
  roomImage: string = '';

  // Form state
  taskTitle = '';
  selectedPriority: number | null = null;   
  selectedDifficulty: number | null = null; 
  selectedDuration: number | null = null;   
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

    // <-- ADD THESE TWO LINES HERE to capture the room data -->
    this.roomName = history.state?.roomName || 'Room';
    this.roomImage = history.state?.roomImage || 'assets/rooms/default.png';

    this.http.get<Housemate[]>(`${this.baseUrl}/Housemates`).subscribe({
      next: data => {
        // We catch the data, but ONLY keep the ones matching this householdId!
        this.allHousemates = data.filter(h => h.householdId === this.householdId);
      },
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

  // ── Selections ──
  selectPriority(value: number) {
    this.selectedPriority = this.selectedPriority === value ? null : value;
  }

  selectDuration(value: number) {
    this.selectedDuration = this.selectedDuration === value ? null : value;
  }

  selectDifficulty(value: number) {
    this.selectedDifficulty = this.selectedDifficulty === value ? null : value;
  }

  // ── Housemate search & Autocomplete ──
  filterHousemates() {
    const q = this.searchName.toLowerCase().trim();
    this.filteredHousemates = q
      ? this.allHousemates.filter(h => h.name.toLowerCase().includes(q))
      : [];
      
    if (this.selectedHousemate && !this.selectedHousemate.name.toLowerCase().includes(q)) {
      this.selectedHousemate = null;
    }
  }

  selectHousemate(h: Housemate) {
    this.selectedHousemate = h;
    this.searchName = h.name;
    this.filteredHousemates = [];
  }

  closeDropdown() {
    setTimeout(() => this.filteredHousemates = [], 200);
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

  // ── Submit ──
  submit() {
    if (!this.isValid() || this.submitting) return;

    this.submitting = true;
    this.errorMsg = '';

    // Create the task object using the EXACT names the database expects
    const newTask = {
      id: 0,
      householdId: this.householdId,
      roomId: this.roomId,
      title: this.taskTitle.trim(),
      difficulty: this.selectedDifficulty!,
      priority: this.selectedPriority!,
      estimatedDurationMinutes: this.selectedDuration!
    };

    // ... keep the rest of your HTTP POST logic exactly the same ...

    this.http.post<any>(`${this.baseUrl}/Tasks`, newTask).subscribe({
      next: (createdTask) => {
        const taskId = createdTask?.id ?? createdTask?.Id;
        const assignment = {
          id: 0,
          taskId: taskId,
          housemateId: this.selectedHousemate!.id
        };

        this.http.post(`${this.baseUrl}/TaskAssignments`, assignment).subscribe({
          next: () => {
            this.submitting = false;
            this.goBack(); // Redirects you back to the room upon success!
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

 // In create-task.ts
goBack() {
  this.router.navigate(['/room', this.householdId, this.roomId], {
    state: { 
      roomName: this.roomName, 
      roomImage: this.roomImage 
    }
  });
  }
}