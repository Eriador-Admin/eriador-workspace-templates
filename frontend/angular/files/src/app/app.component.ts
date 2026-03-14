import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  template: `
    <header style="padding: 1rem 2rem; background: #1976d2; color: white;">
      <h1>{{APP_TITLE}}</h1>
    </header>
    <main style="padding: 2rem;">
      <router-outlet />
    </main>
  `,
})
export class AppComponent {}
