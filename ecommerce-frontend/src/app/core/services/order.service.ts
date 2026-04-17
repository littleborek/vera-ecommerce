import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpParams } from '@angular/common/http';
import { Observable, forkJoin, of, throwError } from 'rxjs';
import { catchError, map, switchMap } from 'rxjs/operators';
import { environment } from '../../../environments/environment';

export interface OrderItem {
  product_id: number;
  quantity: number;
  unit_price: number;
  productName?: string;
  imageUrl?: string;
  seller_id?: number;
}

export type OrderStatus =
  | 'PENDING'
  | 'PROCESSING'
  | 'SHIPPED'
  | 'DELIVERED'
  | 'CANCELLED'
  | 'RETURN_REQUESTED'
  | 'RETURNED';

export interface Order {
  id: number;
  user_id: number;
  status: OrderStatus;
  total_price: number;
  created_at: Date | string;
  items: OrderItem[];
}

export interface TrackingInfo {
  number: string;
  url: string;
  carrier: string;
}

interface BackendOrderItem {
  productId: number;
  quantity: number;
  unitPrice: number;
  productName?: string;
  imageUrl?: string;
  sellerId?: number;
}

interface BackendOrder {
  id: number;
  userId: number;
  status: OrderStatus;
  totalPrice: number;
  createdAt?: string;
  orderItems: BackendOrderItem[];
}

@Injectable({
  providedIn: 'root',
})
export class OrderService {
  private readonly apiUrl = environment.apiUrl;
  private readonly httpClient = inject(HttpClient);

  public readonly orderStatuses: OrderStatus[] = [
    'PENDING',
    'PROCESSING',
    'SHIPPED',
    'DELIVERED',
    'CANCELLED',
    'RETURN_REQUESTED',
    'RETURNED',
  ];

  getOrdersByUserId(_userId: number): Observable<Order[]> {
    return this.httpClient.get<BackendOrder[]>(`${this.apiUrl}/orders/my`).pipe(
      map((orders) => this.normalizeOrders(orders)),
      catchError(this.handleError)
    );
  }

  getOrderById(orderId: number, _userId: number): Observable<Order | undefined> {
    return this.httpClient.get<BackendOrder>(`${this.apiUrl}/orders/${orderId}`).pipe(
      map((order) => this.normalizeOrder(order)),
      catchError((error) => {
        if (error.status === 404 || error.status === 403) {
          return of(undefined);
        }
        return this.handleError(error);
      })
    );
  }

  getAllOrders(): Observable<Order[]> {
    return this.httpClient
      .get<BackendOrder[]>(`${this.apiUrl}/admin/orders/all`)
      .pipe(map((orders) => this.normalizeOrders(orders)), catchError(this.handleError));
  }

  updateOrderStatus(orderId: number, newStatus: OrderStatus): Observable<Order | null> {
    const params = new HttpParams().set('status', newStatus);
    return this.httpClient
      .put<BackendOrder>(`${this.apiUrl}/admin/order-status/${orderId}`, null, { params })
      .pipe(
        map((order) => this.normalizeOrder(order)),
        catchError((error) => {
          if (error.status === 404) {
            return of(null);
          }
          return this.handleError(error);
        })
      );
  }

  getOrdersBySellerId(_sellerId: number): Observable<Order[]> {
    return this.httpClient
      .get<BackendOrder[]>(`${this.apiUrl}/seller/orders`)
      .pipe(map((orders) => this.normalizeOrders(orders)), catchError(this.handleError));
  }

  updateOrderStatusBySeller(
    orderId: number,
    newStatus: OrderStatus,
    _sellerId: number
  ): Observable<Order | null> {
    const params = new HttpParams().set('status', newStatus);
    return this.httpClient
      .put<BackendOrder>(`${this.apiUrl}/seller/orders/${orderId}/status`, null, { params })
      .pipe(
        map((order) => this.normalizeOrder(order)),
        catchError((error) => {
          if (error.status === 404) {
            return of(null);
          }
          return this.handleError(error);
        })
      );
  }

  cancelOrder(orderId: number, _userId: number): Observable<Order | null> {
    return this.httpClient
      .put<BackendOrder>(`${this.apiUrl}/orders/${orderId}/cancel`, null)
      .pipe(
        map((order) => this.normalizeOrder(order)),
        catchError((error) => {
          if (error.status === 404) {
            return of(null);
          }
          return this.handleError(error);
        })
      );
  }

  requestReturn(orderId: number, _userId: number): Observable<Order | null> {
    return this.httpClient
      .put<BackendOrder>(`${this.apiUrl}/orders/${orderId}/return-request`, null)
      .pipe(
        map((order) => this.normalizeOrder(order)),
        catchError((error) => {
          if (error.status === 404) {
            return of(null);
          }
          return this.handleError(error);
        })
      );
  }

  getOrderDetailForSeller(orderId: number, sellerId: number): Observable<Order | undefined> {
    return this.getOrdersBySellerId(sellerId).pipe(
      map((orders) => orders.find((order) => order.id === orderId))
    );
  }

  getTrackingInfo(orderId: number, userId: number): Observable<TrackingInfo | null> {
    return this.getOrderById(orderId, userId).pipe(
      map((order) => {
        if (!order || (order.status !== 'SHIPPED' && order.status !== 'DELIVERED')) {
          return null;
        }
        return {
          number: `VERA-${order.id}-${order.status}`,
          url: '#',
          carrier: 'Platform Logistics',
        };
      })
    );
  }

  getInvoiceLink(orderId: number, userId: number): Observable<string | null> {
    return this.getOrderById(orderId, userId).pipe(
      map((order) => {
        if (!order || order.status === 'CANCELLED' || order.status === 'PENDING') {
          return null;
        }

        const invoiceText = [
          `Invoice for Order #${order.id}`,
          `Status: ${order.status}`,
          `Total: $${order.total_price.toFixed(2)}`,
          '',
          ...order.items.map(
            (item) =>
              `${item.productName || `Product ${item.product_id}`} x${item.quantity} - $${(
                item.unit_price * item.quantity
              ).toFixed(2)}`
          ),
        ].join('\n');

        return `data:text/plain;charset=utf-8,${encodeURIComponent(invoiceText)}`;
      })
    );
  }

  getOrderByIdForAdmin(orderId: number): Observable<Order | undefined> {
    return this.getAllOrders().pipe(
      map((orders) => orders.find((order) => order.id === orderId))
    );
  }

  getReturnRequestsBySellerId(sellerId: number): Observable<Order[]> {
    return this.getOrdersBySellerId(sellerId).pipe(
      map((orders) =>
        orders.filter(
          (order) =>
            order.status === 'RETURN_REQUESTED' || order.status === 'RETURNED'
        )
      )
    );
  }

  private normalizeOrders(orders: BackendOrder[]): Order[] {
    return [...orders]
      .map((order) => this.normalizeOrder(order))
      .sort(
        (a, b) =>
          new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
      );
  }

  private normalizeOrder(order: BackendOrder): Order {
    return {
      id: order.id,
      user_id: order.userId,
      status: order.status,
      total_price: Number(order.totalPrice ?? 0),
      created_at: order.createdAt ? new Date(order.createdAt) : new Date(),
      items: (order.orderItems ?? []).map((item) => ({
        product_id: item.productId,
        quantity: item.quantity,
        unit_price: Number(item.unitPrice ?? 0),
        productName: item.productName,
        imageUrl: item.imageUrl,
        seller_id: item.sellerId,
      })),
    };
  }

  private handleError(error: HttpErrorResponse): Observable<never> {
    let errorMessage = 'An unknown error occurred.';

    if (error.error?.message) {
      errorMessage = error.error.message;
    } else if (error.error?.error) {
      errorMessage = error.error.error;
    } else if (typeof error.error === 'string') {
      errorMessage = error.error;
    } else if (error.status === 403) {
      errorMessage = 'You are not authorized for this order action.';
    } else if (error.status === 404) {
      errorMessage = 'Order not found.';
    } else if (error.message) {
      errorMessage = error.message;
    }

    return throwError(() => new Error(errorMessage));
  }
}
