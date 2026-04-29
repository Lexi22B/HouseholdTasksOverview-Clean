export interface Task {
  id: number;
  householdId: number;
  roomId: number;
  title: string;
  description: string;
  difficulty: number;
  priority: number;
  estimatedDurationMinutes: number;
  isRecurring: boolean;
  recurrencePattern: string;
  isActive: boolean;
  createdAt: Date;
}
