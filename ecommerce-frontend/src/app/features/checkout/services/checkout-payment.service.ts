import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class CheckoutPaymentService {
  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl;

  createStripeCheckoutSession(orderId: number): Observable<string> {
    return this.http.post(`${this.apiUrl}/payments/checkout-session`, null, {
      params: { orderId },
      responseType: 'text',
    });
  }
}
