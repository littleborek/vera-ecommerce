import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';

export interface AiChatRequest {
  question: string;
}

export interface AiChatResponse {
  answer: string;
  visualizationCode?: string;
  isError: boolean;
}

@Injectable({
  providedIn: 'root',
})
export class AiChatService {
  private readonly apiUrl = environment.apiUrl;

  constructor(private http: HttpClient) {}

  ask(question: string): Observable<AiChatResponse> {
    return this.http.post<AiChatResponse>(
      `${this.apiUrl}/chat/ask`,
      { question }
    );
  }
}
