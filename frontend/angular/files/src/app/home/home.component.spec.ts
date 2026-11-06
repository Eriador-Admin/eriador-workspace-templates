import { TestBed } from '@angular/core/testing';
import { HomeComponent } from './home.component';

describe('HomeComponent', () => {
  it('renders the welcome heading', async () => {
    await TestBed.configureTestingModule({ imports: [HomeComponent] }).compileComponents();
    const fixture = TestBed.createComponent(HomeComponent);
    fixture.detectChanges();
    const heading = fixture.nativeElement.querySelector('h2') as HTMLElement;
    expect(heading.textContent).toContain('Welcome');
  });
});
