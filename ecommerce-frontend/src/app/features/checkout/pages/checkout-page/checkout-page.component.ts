import { Component, inject } from '@angular/core';
import { finalize } from 'rxjs/operators';
import { ToastrService } from 'ngx-toastr';
import { CartService } from '../../../../core/services/cart.service';
import { CheckoutPaymentService } from '../../services/checkout-payment.service';

@Component({
  selector: 'app-checkout-page',
  standalone: false,
  templateUrl: './checkout-page.component.html',
  styleUrl: './checkout-page.component.css'
})
export class CheckoutPageComponent {
  private cartService = inject(CartService);
  private checkoutPaymentService = inject(CheckoutPaymentService);
  private toastr = inject(ToastrService);

  isSubmitting = false;

  submitStripeCheckout(): void {
    if (this.isSubmitting) {
      return;
    }

    this.isSubmitting = true;

    this.cartService
      .checkout()
      .pipe(finalize(() => (this.isSubmitting = false)))
      .subscribe((checkoutResponse) => {
        const orderId = checkoutResponse?.orderId;
        if (!orderId) {
          return;
        }

        this.checkoutPaymentService
          .createStripeCheckoutSession(orderId)
          .subscribe({
            next: (checkoutUrl) => {
              window.location.href = checkoutUrl;
            },
            error: (error) => {
              console.error('Stripe checkout session error:', error);
              this.toastr.error(
                'Stripe checkout could not be started.',
                'Payment Error'
              );
            },
          });
      });
  }

}
