import { Component, OnInit, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { TaskService } from '../../services/task-service';
import { TaskAssignmentService } from '../../services/task-assignment-service';
import { TaskCompletionService } from '../../services/task-completion-service';
import { HousemateService } from '../../services/housemate-service';
import { HouseholdService } from '../../services/household-service';

import { Task } from '../../model/task';
import { TaskAssignment } from '../../model/task-assignment';
import { TaskCompletion } from '../../model/task-completion';
import { Housemate } from '../../model/housemate';
import { Household } from '../../model/household';

import { HousematesPopup } from '../housemates-popup/housemates-popup'; // Adjust path if needed
import { RoomService } from '../../services/room-service'; // <-- import room service for image 
import { Room } from '../../model/room';


interface TaskWithStatus extends Task {
  assignment?: TaskAssignment;
  completion?: TaskCompletion;
  housemate?: Housemate;
}
@Component({
  selector: 'app-room-view',
  standalone: true,
  imports: [CommonModule, FormsModule, HousematesPopup],
  templateUrl: './room-view.html',
  styleUrl: './room-view.css',
  schemas: [CUSTOM_ELEMENTS_SCHEMA] /* <-- ADD THIS LINE! */
})

export class RoomViewComponent implements OnInit {

  roomId!: number;
  householdId!: number;
  roomName: string = 'Room';
  roomImage: string = 'assets/rooms/default.png';
  tasks: TaskWithStatus[] = [];

  // Housemates popup
  showHousematesPopup = false;
  housematesList: Housemate[] = [];

  // House profile popup
  showHouseProfilePopup = false;
  household: Household | null = null;
  houseProfileError: string = '';


  // Change password form
  showChangePasswordForm = false;
  newPassword: string = '';
  confirmNewPassword: string = '';
  passwordChangeError: string = '';
  passwordChangeSuccess: string = '';

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
    private housemateService: HousemateService,
    private householdService: HouseholdService,
    private roomService: RoomService // <-- Ensure "private" is here
  ) { }

  ngOnInit() {
    this.roomId = Number(this.route.snapshot.paramMap.get('id'));
    this.householdId = Number(this.route.snapshot.paramMap.get('householdId'));

    if (!this.householdId) {
      this.householdId = Number(localStorage.getItem('householdId'));
    }

    this.roomName = history.state?.roomName || 'Room';
    this.roomImage = history.state?.roomImage || 'assets/rooms/default.png';

    // 2. If missing, fetch from database using the roomId
    if (!this.roomImage || !this.roomName || this.roomName === 'Room') {
    this.roomService.getById(this.roomId).subscribe((room: Room) => {
      this.roomName = room.roomName;
      this.roomImage = room.imageUrl || 'assets/rooms/default.png';
    });
  }

    this.loadData();
    this.loadHousehold();
  }

  loadData() {
    this.taskService.getAll().subscribe(allTasks => {
      const roomTasks = allTasks.filter(t => t.roomId === this.roomId);

      this.taskAssignmentService.getAll().subscribe(assignments => {
        this.taskCompletionService.getAll().subscribe(completions => {
          this.housemateService.getAll().subscribe(housemates => {
            
            // FILTER: Only keep housemates linked to this specific household ID
            this.housematesList = housemates.filter(h => h.householdId === this.householdId);
            
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

  loadHousehold() {
    const householdId = Number(localStorage.getItem('householdId'));

    if (!householdId) {
      this.houseProfileError = 'No household is currently logged in.';
      return;
    }

    this.householdService.getById(householdId).subscribe({
      next: (household) => {
        this.household = household;
        this.houseProfileError = '';
      },
      error: (err) => {
        console.error('Could not load household', err);
        this.houseProfileError = 'Could not load house profile.';
      }
    });
  }

  openHouseProfilePopup() {
    this.loadHousehold();
    this.showHouseProfilePopup = true;

    this.showChangePasswordForm = false;
    this.newPassword = '';
    this.confirmNewPassword = '';
    this.passwordChangeError = '';
    this.passwordChangeSuccess = '';
  }

  closeHouseProfilePopup() {
    this.showHouseProfilePopup = false;

    this.showChangePasswordForm = false;
    this.newPassword = '';
    this.confirmNewPassword = '';
    this.passwordChangeError = '';
    this.passwordChangeSuccess = '';
  }

  openHousematesPopup() {
    this.showHousematesPopup = true;
  }

  closeHousematesPopup() {
    this.showHousematesPopup = false;
  }

  openChangePasswordForm() {
    this.showChangePasswordForm = true;
    this.passwordChangeError = '';
    this.passwordChangeSuccess = '';
  }

  saveNewPassword() {
    this.passwordChangeError = '';
    this.passwordChangeSuccess = '';

    if (this.newPassword.length < 8) {
      this.passwordChangeError = 'Please include at least 8 characters.';
      return;
    }

    if (this.newPassword !== this.confirmNewPassword) {
      this.passwordChangeError = 'Passwords do not match.';
      return;
    }

    const householdId = Number(localStorage.getItem('householdId'));

    if (!householdId) {
      this.passwordChangeError = 'No household is currently logged in.';
      return;
    }

    this.householdService.changePassword(householdId, this.newPassword).subscribe({
      next: () => {
        this.passwordChangeSuccess = 'Password updated successfully.';
        this.newPassword = '';
        this.confirmNewPassword = '';
        this.showChangePasswordForm = false;
      },
      error: (err) => {
        console.error('Password update failed', err);
        this.passwordChangeError = 'Could not update password. Try again.';
      }
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
      assignmentId: task.assignment.id
    };

    this.taskCompletionService.create(completion).subscribe(() => this.loadData());
  }

  markUndone(task: TaskWithStatus) {
    if (!task.completion) return;

    this.taskCompletionService.delete(task.completion.id).subscribe(() => this.loadData());
  }

  deleteTask(task: TaskWithStatus) {
    const deleteCompletion = task.completion
      ? this.taskCompletionService.delete(task.completion.id)
      : null;

    const proceed = () => {
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
    this.router.navigate(['/create-task', this.householdId, this.roomId], {
      state: { 
        roomName: this.roomName, 
        roomImage: this.roomImage 
      }
    });
  }

  goBack() {
    this.router.navigate(['/home']);
  }

// Functions to display task features 
 getPriorityLabel(p?: number): string {
    return p ? this.priorityLabels[p] || 'Low' : 'Low';
  }

  getPriorityColor(p?: number): string {
    return p ? this.priorityColors[p] || '#1A6552' : '#1A6552';
  }

  getEffortLabel(d?: number): string {
    const labels: { [k: number]: string } = {
      1: 'Easy',
      2: 'Moderate',
      3: 'Difficult'
    };
    return d ? labels[d] || 'Easy' : 'Easy';
  }

  getDurationLabel(d?: number): string {
    const labels: { [k: number]: string } = {
      1: '15 min',
      2: '30 min',
      3: '60 min'
    };
    return d ? labels[d] || '' : '';
  }
}