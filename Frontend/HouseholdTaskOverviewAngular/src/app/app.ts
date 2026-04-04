// app.ts = main container of the whole app, first thing which loads
import { Component } from '@angular/core';
import { RouterOutlet, RouterLink } from '@angular/router';
import { HouseholdList } from './component/household-list/household-list';
import { HouseholdCard } from './component/household-card/household-card';
import { HousemateList } from './component/housemate-list/housemate-list';
import { HousemateCard } from './component/housemate-card/housemate-card';
import { RoomList } from './component/room-list/room-list';
import { RoomCard } from './component/room-card/room-card';
import { TaskList } from './component/task-list/task-list';
import { TaskCard } from './component/task-card/task-card';
import { TaskAssignmentList } from './component/task-assignment-list/task-assignment-list';
import { TaskAssignmentCard } from './component/task-assignment-card/task-assignment-card';
import { TaskCompletionList } from './component/task-completion-list/task-completion-list';
import { TaskCompletionCard } from './component/task-completion-card/task-completion-card';

@Component({ 
  selector: 'app-root',
  standalone: true,
  imports: [
    RouterOutlet,
    RouterLink,
    HouseholdList,
    HouseholdCard,
    HousemateList,
    HousemateCard,
    RoomList,
    RoomCard,
    TaskList,
    TaskCard,
    TaskAssignmentList,
    TaskAssignmentCard,
    TaskCompletionList,
    TaskCompletionCard
  ],
  templateUrl: './app.html'
})
export class App {}