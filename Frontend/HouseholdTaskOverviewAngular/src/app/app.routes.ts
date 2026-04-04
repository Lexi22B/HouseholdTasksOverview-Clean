import { Routes } from '@angular/router';
import { HouseholdList } from './component/household-list/household-list'; 
import { HousemateList } from './component/housemate-list/housemate-list';
import { RoomList } from './component/room-list/room-list';
import { TaskList } from './component/task-list/task-list';
import { TaskAssignmentList } from './component/task-assignment-list/task-assignment-list';
import { TaskCompletionList } from './component/task-completion-list/task-completion-list';

export const routes: Routes = //routes = pages
[
    { path: 'households', component: HouseholdList },
    { path: 'housemates', component: HousemateList },
    { path: 'rooms', component: RoomList },
    { path: 'tasks', component: TaskList },
    { path: 'taskassignments', component: TaskAssignmentList },
    { path: 'taskcompletions', component: TaskCompletionList },
];
