export interface Task {
  id: number;
  householdId: number;
  roomId: number;
  title: string;
  difficulty: number;
  priority: number;
  estimatedDurationMinutes: number;
  isActive: boolean;
  createdAt: Date;
}
