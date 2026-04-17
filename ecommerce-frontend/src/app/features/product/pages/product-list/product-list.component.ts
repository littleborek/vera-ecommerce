import { Component, OnInit, OnDestroy, inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import {
  ProductService,
  Product,
  ProductFilterOptions,
} from '../../services/product.service';
import { CartService } from '../../../../core/services/cart.service';
import { ToastrService } from 'ngx-toastr';
import { forkJoin, Subscription, of } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css'],
  standalone: false,
})
export class ProductListComponent implements OnInit, OnDestroy {
  products: Product[] = [];
  filteredProducts: Product[] = [];
  isLoading: boolean = true;
  errorLoading: string | null = null; // Tip: string | null

  filterOptions: ProductFilterOptions = {
    categories: [],
    priceRange: { min: 0, max: 0 },
  };
  selectedCategory: string | null = null;
  currentMinPrice: number = 0;
  currentMaxPrice: number = 0;
  currentSortOrder: string = 'default';
  currentSearchTerm: string | null = null;
  currentPage: number = 0;
  pageSize: number = 24;
  totalPages: number = 0;
  totalElements: number = 0;

  private queryParamSubscription: Subscription | null = null;

  private productService = inject(ProductService);
  private cartService = inject(CartService);
  private toastr = inject(ToastrService);
  private route = inject(ActivatedRoute);

  ngOnInit(): void {
    this.loadInitialData();
    this.subscribeToQueryParams();
  }

  ngOnDestroy(): void {
    this.queryParamSubscription?.unsubscribe();
  }

  subscribeToQueryParams(): void {
    this.queryParamSubscription = this.route.queryParamMap.subscribe(
      (params) => {
        const newSearchTerm = params.get('search');
        if (this.currentSearchTerm !== newSearchTerm) {
          this.currentSearchTerm = newSearchTerm;
          if (!this.isLoading) {
            this.currentPage = 0;
            this.loadProducts();
          }
        }
      }
    );
  }

  loadInitialData(): void {
    this.isLoading = true;
    this.errorLoading = null;

    const filterOptions$ = this.productService.getFilterOptions().pipe(
      catchError((err) => {
        console.warn(
          'Could not load filter options (using defaults):',
          err.message
        );
        return of({ categories: [], priceRange: { min: 0, max: 0 } });
      })
    );

    forkJoin({
      filters: filterOptions$,
    }).subscribe({
      next: ({ filters }) => {
        this.filterOptions = filters;
        this.currentMinPrice = filters.priceRange.min;
        this.currentMaxPrice = filters.priceRange.max;
        this.loadProducts();
      },
      error: (err) => {
        console.error('Error loading initial product data:', err);
        this.errorLoading = err.message || 'Failed to load products.';
        // --- DÜZELTME ---
        // errorLoading null olabileceğinden, ?? operatörü ile varsayılan mesaj sağla
        this.toastr.error(
          this.errorLoading ?? 'Failed to load products.',
          'Error'
        );
        // --- DÜZELTME SONU ---
        this.isLoading = false;
        this.filteredProducts = [];
        this.filterOptions = { categories: [], priceRange: { min: 0, max: 0 } };
      },
    });
  }

  loadProducts(): void {
    this.isLoading = true;
    this.errorLoading = null;

    this.productService
      .browseProducts({
        page: this.currentPage,
        size: this.pageSize,
        category: this.selectedCategory,
        search: this.currentSearchTerm,
        minPrice: this.currentMinPrice,
        maxPrice: this.currentMaxPrice,
        sort: this.currentSortOrder,
      })
      .subscribe({
        next: (response) => {
          this.products = response.items;
          this.filteredProducts = response.items;
          this.totalPages = response.totalPages;
          this.totalElements = response.totalElements;
          this.isLoading = false;
        },
        error: (err) => {
          console.error('Error loading products:', err);
          this.errorLoading = err.message || 'Failed to load products.';
          this.toastr.error(this.errorLoading ?? 'Failed to load products.', 'Error');
          this.products = [];
          this.filteredProducts = [];
          this.totalPages = 0;
          this.totalElements = 0;
          this.isLoading = false;
        },
      });
  }

  selectCategory(category: string | null): void {
    this.selectedCategory = category;
    this.currentPage = 0;
    this.loadProducts();
  }

  onPriceChange(): void {
    if (Number(this.currentMinPrice) > Number(this.currentMaxPrice)) {
      this.currentMinPrice = this.currentMaxPrice;
    }
    this.currentPage = 0;
    this.loadProducts();
  }

  onSortChange(): void {
    this.currentPage = 0;
    this.loadProducts();
  }

  goToPreviousPage(): void {
    if (this.currentPage === 0) return;
    this.currentPage -= 1;
    this.loadProducts();
  }

  goToNextPage(): void {
    if (this.currentPage + 1 >= this.totalPages) return;
    this.currentPage += 1;
    this.loadProducts();
  }

  addToCart(product: Product): void {
    if (!product || !product.id) {
      // ID kontrolü eklendi
      this.toastr.error('Cannot add item: Invalid product data.', 'Error');
      return;
    }
    // CartService.addItem artık productId ve quantity bekliyor
    this.cartService.addItem(product.id, 1); // product yerine product.id gönderildi
    this.toastr.success(`${product.name} added to cart!`, 'Success');
  }
}
