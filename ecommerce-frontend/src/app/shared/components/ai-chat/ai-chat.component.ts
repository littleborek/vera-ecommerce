import { Component, ElementRef, ViewChild, AfterViewChecked } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Observable } from 'rxjs';
import { AiChatService, AiChatResponse } from '../../../core/services/ai-chat.service';
import { AuthService } from '../../../core/services/auth.service';
import { SafeHtml } from '@angular/platform-browser';
import DOMPurify from 'dompurify';

declare var Plotly: any;

interface Message {
  text: string;
  sender: 'user' | 'bot';
  timestamp: Date;
  visualizationCode?: string;
  renderedHtml?: string;
}

@Component({
  selector: 'app-ai-chat',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './ai-chat.component.html',
  styleUrls: ['./ai-chat.component.css']
})
export class AiChatComponent implements AfterViewChecked {
  @ViewChild('scrollMe') private myScrollContainer!: ElementRef;

  isOpen = false;
  userInput = '';
  messages: Message[] = [
    {
      text: 'Hello! I am your E-Commerce Analytics Assistant. How can I help you today?',
      sender: 'bot',
      timestamp: new Date()
    }
  ];
  isLoading = false;
  isLoggedIn$: Observable<boolean>;
  currentUser$: Observable<any>;

  constructor(
    private aiChatService: AiChatService,
    private authService: AuthService
  ) {
    this.isLoggedIn$ = this.authService.isLoggedIn$;
    this.currentUser$ = this.authService.currentUser$;
  }

  ngAfterViewChecked() {
    this.scrollToBottom();
  }

  toggleChat() {
    this.isOpen = !this.isOpen;
  }

  sendMessage() {
    if (!this.userInput.trim() || this.isLoading) return;

    const userMessage: Message = {
      text: this.userInput,
      sender: 'user',
      timestamp: new Date()
    };

    this.messages.push(userMessage);
    const question = this.userInput;
    this.userInput = '';
    this.isLoading = true;

    this.aiChatService.ask(question).subscribe({
      next: (res: AiChatResponse) => {
        const botMessage: Message = {
          text: '',
          sender: 'bot',
          timestamp: new Date(),
          visualizationCode: res.visualizationCode
        };

        this.messages.push(botMessage);
        this.isLoading = false;

        this.streamBotMessage(botMessage, res);
      },
      error: (err) => {
        this.messages.push({
          text: 'Sorry, I encountered an error. Please contact admin.',
          sender: 'bot',
          timestamp: new Date()
        });
        this.isLoading = false;
      }
    });
  }

  private streamBotMessage(message: Message, response: AiChatResponse) {
    const fullText = response.answer ?? '';
    let cursor = 0;

    const tick = () => {
      cursor += Math.max(1, Math.ceil((fullText.length - cursor) / 18));
      message.text = fullText.slice(0, cursor);
      message.renderedHtml = this.renderMarkdown(message.text);

      if (cursor < fullText.length) {
        setTimeout(tick, 18);
        return;
      }

      if (response.visualizationCode) {
        setTimeout(() => {
          this.renderPlot(response.visualizationCode!, this.messages.indexOf(message));
        }, 80);
      }
    };

    tick();
  }

  private renderPlot(code: string, index: number) {
    try {
      const data = JSON.parse(code);
      const elementId = 'viz-' + index;
      const normalized = this.normalizePlotConfig(data);

      Plotly.newPlot(elementId, normalized.data, normalized.layout, normalized.config);
      setTimeout(() => Plotly.Plots.resize(elementId), 50);
    } catch (e) {
      console.error('Plotly render error:', e);
    }
  }

  private normalizePlotConfig(plot: any) {
    const originalLayout = plot?.layout ?? {};
    const firstTrace = Array.isArray(plot?.data) ? plot.data[0] : null;
    const rawLabels = Array.isArray(firstTrace?.x) ? firstTrace.x : Array.isArray(firstTrace?.y) ? firstTrace.y : [];
    const rawValues = Array.isArray(firstTrace?.y) ? firstTrace.y : Array.isArray(firstTrace?.x) ? firstTrace.x : [];

    const pairedValues = rawLabels
      .map((label: unknown, index: number) => ({
        label: String(label ?? ''),
        value: Number(rawValues[index] ?? 0)
      }))
      .filter((item: { label: string; value: number }) => item.label && Number.isFinite(item.value))
      .sort((a: { value: number }, b: { value: number }) => b.value - a.value)
      .slice(0, 8);

    const labels = pairedValues.map((item: { label: string }) => item.label);
    const values = pairedValues.map((item: { value: number }) => item.value);
    const maxLabelLength = labels.reduce((max: number, label: string) => Math.max(max, label.length), 0);
    const leftMargin = Math.min(240, Math.max(120, maxLabelLength * 9));
    const chartHeight = Math.max(320, labels.length * 44 + 120);

    const normalizedData = [{
      type: 'bar',
      orientation: 'h',
      x: values,
      y: labels,
      text: values.map((value: number) => this.formatChartValue(value)),
      textposition: 'outside',
      cliponaxis: false,
      marker: {
        color: '#2563eb',
        line: {
          color: '#1d4ed8',
          width: 1
        }
      },
      hovertemplate: '%{y}: %{x}<extra></extra>'
    }];

    return {
      data: normalizedData,
      layout: {
        autosize: true,
        height: chartHeight,
        paper_bgcolor: 'rgba(0,0,0,0)',
        plot_bgcolor: '#ffffff',
        font: {
          family: 'Georgia, Times New Roman, serif',
          color: '#1f2937'
        },
        bargap: 0.28,
        margin: { t: 56, r: 48, b: 40, l: leftMargin },
        title: {
          text: this.stripHtml(originalLayout?.title?.text || originalLayout?.title || 'Analysis Chart'),
          x: 0.03,
          xanchor: 'left'
        },
        xaxis: {
          automargin: true,
          gridcolor: '#e5e7eb',
          zeroline: false,
          title: {
            text: originalLayout?.yaxis?.title?.text || originalLayout?.yaxis?.title || originalLayout?.xaxis?.title?.text || originalLayout?.xaxis?.title || 'Value'
          }
        },
        yaxis: {
          automargin: true,
          gridcolor: '#f3f4f6',
          categoryorder: 'array',
          categoryarray: labels.slice().reverse(),
          title: {
            text: ''
          }
        }
      },
      config: {
        responsive: true,
        displayModeBar: false
      }
    };
  }

  private formatChartValue(value: number): string {
    if (Math.abs(value) >= 1000) {
      return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        maximumFractionDigits: 0
      }).format(value);
    }

    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      maximumFractionDigits: 2
    }).format(value);
  }

  private renderMarkdown(text: string): string {
    const escaped = text
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;');

    const html = escaped
      .replace(/^### (.*)$/gm, '<h3>$1</h3>')
      .replace(/^## (.*)$/gm, '<h2>$1</h2>')
      .replace(/^# (.*)$/gm, '<h1>$1</h1>')
      .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
      .replace(/\*(.*?)\*/g, '<em>$1</em>')
      .replace(/`([^`]+)`/g, '<code>$1</code>')
      .replace(/^\d+\.\s+(.*)$/gm, '<li>$1</li>')
      .replace(/(?:<li>.*<\/li>\n?)+/g, (match) => `<ol>${match}</ol>`)
      .replace(/\n\n/g, '</p><p>')
      .replace(/\n/g, '<br>');

    return DOMPurify.sanitize(`<p>${html}</p>`);
  }

  private stripHtml(value: string): string {
    return DOMPurify.sanitize(String(value).replace(/<[^>]*>/g, ''));
  }

  private scrollToBottom(): void {
    try {
      this.myScrollContainer.nativeElement.scrollTop = this.myScrollContainer.nativeElement.scrollHeight;
    } catch (err) {}
  }
}
