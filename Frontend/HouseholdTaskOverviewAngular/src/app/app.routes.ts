//routes = pages

import { Routes } from '@angular/router';

//Not implemented
import { HouseholdList } from './component/household-list/household-list'; 
import { HousemateList } from './component/housemate-list/housemate-list';
import { RoomList } from './component/room-list/room-list';
import { TaskList } from './component/task-list/task-list';
import { TaskAssignmentList } from './component/task-assignment-list/task-assignment-list';
import { TaskCompletionList } from './component/task-completion-list/task-completion-list';

//Implemented pages
import { WelcomeComponent } from './component/welcome/welcome';
import { RegisterComponent } from './component/register/register';
import { HomeComponent } from './component/home/home';
import { RoomViewComponent } from './component/room-view/room-view';
import { CreateTaskComponent } from './component/create-task/create-task';

export const routes: Routes = 
[
    { path: 'households', component: HouseholdList },
    { path: 'housemates', component: HousemateList },
    { path: 'rooms', component: RoomList },
    { path: 'tasks', component: TaskList },
    { path: 'taskassignments', component: TaskAssignmentList },
    { path: 'taskcompletions', component: TaskCompletionList },
    { path: '', component: WelcomeComponent },
    { path: 'register', component: RegisterComponent },
    { path: 'home', component: HomeComponent },
    //{ path: 'house-profile', component: ... },  // later
    //{ path: 'roommates', component: ... },       // later
    //{ path: 'create-room', component: ... },     // later
    { path: 'room/:id', component: RoomViewComponent },
    { path: 'create-task', component: CreateTaskComponent },   

];
