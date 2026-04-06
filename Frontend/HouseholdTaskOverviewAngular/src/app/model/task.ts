export interface Task 
{
    id: number;
  householdId: number;
  roomId: number;
  taskFrequencyId: number;
  recurrencePattern: string;
  title: string;
  description: string;
  difficultyLevelId: number;
  priorityLevelId: number;
  durationLevelId: number;
  isActive: boolean;
  createdAt: Date;

}
