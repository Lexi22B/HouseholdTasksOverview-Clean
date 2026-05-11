export interface Room {
  id: number;
  householdId: number;
  roomName: string;
  imageUrl?: string; /* <-- Add this new line! */
}
