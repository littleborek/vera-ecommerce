import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AiChatComponent } from './ai-chat.component';
import { AiChatService } from '../../../core/services/ai-chat.service';
import { AuthService } from '../../../core/services/auth.service';
import { of } from 'rxjs';

class MockAiChatService {
  ask(question: string) {
    return of({ answer: 'Mock answer', visualizationCode: null });
  }
}

class MockAuthService {
  isLoggedIn$ = of(true);
  currentUser$ = of({ id: 1, role: 'CUSTOMER' });
}

describe('AiChatComponent', () => {
  let component: AiChatComponent;
  let fixture: ComponentFixture<AiChatComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AiChatComponent], // Standalone component
      providers: [
        { provide: AiChatService, useClass: MockAiChatService },
        { provide: AuthService, useClass: MockAuthService }
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(AiChatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should sanitize generated markdown successfully', () => {
    // Testing the private method securely (we can mock it or check logic)
    // The markdown string:
    const maliciousInput = '# Hello <script>alert("XSS")</script>';
    const result = (component as any).renderMarkdown(maliciousInput);
    
    // Check that DOMPurify stripped the script but kept the H1
    expect(result).not.toContain('<script>');
  });
  
  it('should strip HTML successfully from chart titles', () => {
    const maliciousTitle = 'Sales Data <img src="x" onerror="alert(1)">';
    const result = (component as any).stripHtml(maliciousTitle);
    
    // Check that DOMPurify stripped the script/img completely
    expect(result).not.toContain('<img');
    expect(result).not.toContain('onerror');
  });
});
