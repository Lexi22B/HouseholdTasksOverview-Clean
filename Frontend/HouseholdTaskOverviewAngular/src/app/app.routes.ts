//routes = pages

import { Routes } from '@angular/router';

//Not implemented

//Implemented pages
import { WelcomeComponent } from './component/welcome/welcome';
import { RegisterComponent } from './component/register/register';
import { HomeComponent } from './component/home/home';
import { RoomViewComponent } from './component/room-view/room-view';
import { CreateTaskComponent } from './component/create-task/create-task';

export const routes: Routes =
    [
        { path: '', component: WelcomeComponent },
        { path: 'register', component: RegisterComponent },
        { path: 'home', component: HomeComponent },
        //{ path: 'house-profile', component: ... },  // later
        //{ path: 'roommates', component: ... },       // later
        //{ path: 'create-room', component: ... },     // later
        { path: 'room/:id', component: RoomViewComponent },
        { path: 'create-task', component: CreateTaskComponent },

    ];
