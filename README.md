# Vera E-Commerce Platform

A full-stack e-commerce platform with an AI-powered Analytics Chatbot — built with Spring Boot, Angular, PostgreSQL, and a local LangGraph-based Text2SQL AI service.

---

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [Tech Stack](#tech-stack)
- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started (Docker — Recommended)](#getting-started-docker--recommended)
- [Getting Started (Local Development)](#getting-started-local-development)
- [Environment Variables](#environment-variables)
- [API Reference](#api-reference)
- [AI Analytics Service](#ai-analytics-service)
- [Security Architecture](#security-architecture)
- [CI Pipeline](#ci-pipeline)
- [Default Test Accounts](#default-test-accounts)

---

## Architecture Overview

```
┌─────────────────┐        ┌──────────────────────┐        ┌─────────────────────┐
│  Angular        │ ──────▶│  Spring Boot         │ ──────▶│  PostgreSQL 17      │
│  Frontend       │        │  Backend (REST API)   │        │  Database           │
│  :4200          │◀────── │  :8080               │        │  :5432              │
└─────────────────┘        └──────────┬───────────┘        └─────────────────────┘
                                      │ Internal API Key
                                      ▼
                           ┌──────────────────────┐        ┌─────────────────────┐
                           │  Python AI Service   │ ──────▶│  LM Studio          │
                           │  (LangGraph/FastAPI) │        │  (Local LLM Server) │
                           │  :8000               │◀────── │  :1234              │
                           └──────────────────────┘        └─────────────────────┘
```

- The **Frontend** communicates only with the **Backend** (never directly with the AI service).
- The **Backend** forwards analytics queries to the **AI Service** using an internal API key.
- The **AI Service** generates SQL, executes it via the backend's secure endpoint, and returns a natural language answer.
- The **LLM** runs locally via **LM Studio** (no external API calls, full privacy).

---

## Tech Stack

| Layer | Technology |
| :--- | :--- |
| Frontend | Angular 17, TypeScript, TailwindCSS, Ngx-Charts |
| Backend | Spring Boot 3.2, Java 21, Spring Security, JWT |
| Database | PostgreSQL 17 |
| AI Service | Python 3.9, FastAPI, LangGraph, LangChain |
| LLM | LM Studio (local, OpenAI-compatible API) |
| DevOps | Docker, Docker Compose, GitHub Actions CI |

---

## Features

### Customer
- Browse and search products with category filtering
- Product detail pages with reviews
- Shopping cart (add, update quantity, remove, clear)
- Checkout → order creation with stock validation
- Order history and detail view
- Return request flow

### Seller
- Seller Dashboard with sales analytics charts
- Full product CRUD (Create, Update, Delete)
- View and manage incoming orders
- Return request management
- Seller profile management

### Admin
- User management (list, ban/unban, change role)
- Order management (view all, update status)
- Product management with full control
- Platform-wide analytics via AI chatbot

### AI Analytics Chatbot
- Multi-agent LangGraph pipeline (Router → SQL Generator → SQL Fixer → Analyst → Visualizer)
- Natural language to SQL (Text2SQL) with schema awareness
- Role-based data isolation (sellers see only their store data)
- Security hardened: blocks `SELECT *`, SQL comments, sensitive columns (`password`, `password_hash`), and prompt injection attempts
- Chart visualization for time-series and comparative data
- Supports Turkish and English queries

---

## Project Structure

```
ECOMMERCE/
├── .github/
│   └── workflows/
│       └── ci.yml                  # GitHub Actions CI Pipeline
├── ecommerce-backend/
│   ├── ai-service/                 # Python LangGraph AI Service
│   │   ├── agents.py               # All LangGraph agent nodes
│   │   ├── graph.py                # LangGraph workflow definition
│   │   ├── llm.py                  # LLM factory (LM Studio connection)
│   │   ├── main.py                 # FastAPI application entry point
│   │   ├── schema.py               # Database schema description for LLM
│   │   ├── state.py                # LangGraph state definition
│   │   ├── requirements.txt        # Python dependencies
│   │   ├── tests/                  # AI service unit tests
│   │   └── Dockerfile
│   ├── src/
│   │   └── main/java/berk/kocaborek/ecommerce/
│   │       ├── config/             # Security, CORS, JWT config
│   │       ├── controller/         # REST API controllers
│   │       ├── dto/                # Data Transfer Objects
│   │       ├── entity/             # JPA entities
│   │       ├── exception/          # Global exception handler
│   │       ├── repository/         # Spring Data JPA repositories
│   │       └── service/            # Business logic layer
│   ├── init.sql                    # Database schema + seed data
│   ├── start-backend.sh            # Local development startup script
│   ├── .env.local                  # Local environment variables (not committed)
│   ├── .gitignore
│   ├── Dockerfile
│   └── pom.xml
├── ecommerce-frontend/
│   ├── src/app/
│   │   ├── core/                   # Layout, Header, Footer, Guards, Services
│   │   ├── features/               # Feature modules (auth, seller, admin, etc.)
│   │   └── shared/                 # Shared components (product-form, ai-chat)
│   ├── nginx.conf                  # Nginx config for Docker deployment
│   ├── .gitignore
│   ├── Dockerfile
│   └── angular.json
├── ECOMMERCE_Postman_Collection.json  # API test collection
├── QUICKSTART.md                   # Quick start for new machines
├── README.md                       # This file
└── docker-compose.yml              # Full stack Docker Compose configuration
```

---

## Getting Started (Docker — Recommended)

> For a new machine, also see [QUICKSTART.md](./QUICKSTART.md).

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [LM Studio](https://lmstudio.ai/) with a model downloaded and the local server running on port `1234`

### Steps

**1. Start LM Studio Server**

Open LM Studio, load a model (see recommendations below), go to the **Local Server** tab, and click **Start Server**. Ensure it's on port `1234`.

**2. Run Docker Compose**

```bash
docker-compose up --build
```

This automatically starts:
- PostgreSQL database (initialized with `init.sql`)
- Spring Boot backend
- Python AI service
- Angular frontend

**3. Open in Browser**

```
http://localhost:4200
```

---

## Getting Started (Local Development)

### Backend

**Requirements:** Java 21, Maven, PostgreSQL running locally

```bash
cd ecommerce-backend

# Create your .env.local (see Environment Variables section)
# Then run:
./start-backend.sh
```

### AI Service

**Requirements:** Python 3.9+, LM Studio running

```bash
cd ecommerce-backend/ai-service
python -m venv venv
source venv/bin/activate      # or: venv\Scripts\activate on Windows
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

### Frontend

**Requirements:** Node.js 20+

```bash
cd ecommerce-frontend
npm install
npm start
```

---

## Environment Variables

All secrets are loaded from `ecommerce-backend/.env.local` for local development (Docker Compose inlines them).

| Variable | Description | Required |
| :--- | :--- | :--- |
| `JWT_SECRET` | HS256 signing secret (min 32 chars) | ✅ |
| `ANALYTICS_INTERNAL_API_KEY` | Internal key shared between backend and AI service | ✅ |
| `STRIPE_PUBLIC_KEY` | Stripe publishable key (`pk_test_...`) | ✅ |
| `STRIPE_SECRET_KEY` | Stripe secret key (`sk_test_...`) | ✅ |
| `STRIPE_SUCCESS_URL` | Redirect URL after payment success | ✅ |
| `STRIPE_CANCEL_URL` | Redirect URL after payment cancel | ✅ |
| `STRIPE_WEBHOOK_SECRET` | Stripe webhook signing secret | Optional |
| `LMSTUDIO_BASE_URL` | LM Studio API base URL | ✅ |
| `LMSTUDIO_MODEL` | Active model name in LM Studio | ✅ |

**Example `.env.local`:**
```bash
JWT_SECRET=replace-with-a-strong-secret-at-least-32-bytes
ANALYTICS_INTERNAL_API_KEY=replace-with-a-long-random-internal-key
STRIPE_PUBLIC_KEY=pk_test_yourkey
STRIPE_SECRET_KEY=sk_test_yourkey
STRIPE_SUCCESS_URL=http://localhost:4200/checkout?payment=success
STRIPE_CANCEL_URL=http://localhost:4200/checkout?payment=cancel
STRIPE_WEBHOOK_SECRET=whsec_placeholder
LMSTUDIO_BASE_URL=http://localhost:1234/v1
LMSTUDIO_MODEL=mistralai-mistral-nemo-instruct-2407-12b-mpoa-v1
```

---

## API Reference

Base URL: `http://localhost:8080/api`

### Authentication
| Method | Endpoint | Description | Auth |
| :--- | :--- | :--- | :--- |
| `POST` | `/users/register` | Register a new user | None |
| `POST` | `/users/login` | Login and receive JWT | None |

### Products (Public)
| Method | Endpoint | Description | Auth |
| :--- | :--- | :--- | :--- |
| `GET` | `/products` | List all products (with filters) | None |
| `GET` | `/products/{id}` | Get product by ID | None |

### Cart (Customer)
| Method | Endpoint | Description | Auth |
| :--- | :--- | :--- | :--- |
| `GET` | `/cart/my-cart` | Get current cart | JWT |
| `POST` | `/cart/add` | Add item to cart | JWT |
| `PUT` | `/cart/update/{id}` | Update cart item quantity | JWT |
| `DELETE` | `/cart/remove/{id}` | Remove cart item | JWT |
| `POST` | `/cart/checkout` | Checkout (creates order) | JWT |

### Orders (Customer)
| Method | Endpoint | Description | Auth |
| :--- | :--- | :--- | :--- |
| `GET` | `/orders/my` | Get my orders | JWT |
| `GET` | `/orders/{id}` | Get order by ID | JWT |
| `PUT` | `/orders/{id}/cancel` | Cancel an order | JWT |
| `PUT` | `/orders/{id}/return-request` | Request return | JWT |

### Seller Endpoints
| Method | Endpoint | Description | Auth |
| :--- | :--- | :--- | :--- |
| `GET` | `/seller/my-products` | List seller's products | JWT (SELLER) |
| `POST` | `/seller/product-create` | Create a new product | JWT (SELLER) |
| `PUT` | `/seller/product-update/{id}` | Update a product | JWT (SELLER) |
| `DELETE` | `/seller/product-delete/{id}` | Delete a product | JWT (SELLER) |
| `GET` | `/seller/orders` | Get seller's related orders | JWT (SELLER) |

### Admin Endpoints
| Method | Endpoint | Description | Auth |
| :--- | :--- | :--- | :--- |
| `GET` | `/admin/users` | List all users | JWT (ADMIN) |
| `PUT` | `/admin/users/{id}/ban` | Ban a user | JWT (ADMIN) |
| `PUT` | `/admin/users/{id}/unban` | Unban a user | JWT (ADMIN) |
| `PUT` | `/admin/users/{id}/role` | Change user role | JWT (ADMIN) |
| `GET` | `/admin/orders/all` | List all orders | JWT (ADMIN) |

### AI Analytics
| Method | Endpoint | Description | Auth |
| :--- | :--- | :--- | :--- |
| `POST` | `/analytics/chat` | Send analytics question | JWT |

---

## AI Analytics Service

The AI service runs a multi-agent LangGraph pipeline:

```
Question ──▶ Router ──▶ [DATA] ──▶ SQL Generator ──▶ Execute SQL
                │                       │                  │
                │                       └─── Error ──▶ SQL Fixer ─┐
                │                                                  │
                ├──▶ [GENERAL] ──▶ General Assistant              │
                │                                                  ▼
                └──▶ [OUT_OF_SCOPE] ──▶ Block           Data Analyst ──▶ Visualizer ──▶ Answer
```

**Role-Based Data Isolation:**
- `ADMIN`: Full access to all data
- `SELLER`: Only data from their own store (`stores.owner_id = user_id`)
- `CUSTOMER`: Only their own orders, reviews, cart data

**Recommended Models (LM Studio):**

| Model | Speed | SQL Quality | Memory |
| :--- | :--- | :--- | :--- |
| `Llama-3.1-8B-Instruct` | Fast | Good | ~8GB |
| `Mistral-Nemo-12B-Instruct` | Medium | Very Good | ~12GB |
| `Llama-3-70B-Instruct` | Slow | Excellent | ~40GB+ |

---

## Security Architecture

| Layer | Mechanism |
| :--- | :--- |
| Authentication | JWT (HS256), verified on every request |
| Authorization | Spring Security role-based (`CUSTOMER`, `SELLER`, `ADMIN`) |
| Row-Level Security | Backend enforces `owner_id` / `user_id` filters — never trusts the LLM |
| SQL Injection (AI) | AST-based SQL validation: blocks `SELECT *`, multi-statements, `DROP/INSERT/UPDATE/DELETE`, sensitive columns |
| Internal API Protection | AI→Backend calls require `X-Internal-Api-Key` header |
| Prompt Injection | Router classifies injection attempts as `OUT_OF_SCOPE` and blocks them |
| Sensitive Column Redaction | `password`, `password_hash`, `internal_cost`, `supplier_margin` are blocked at execution level |
| XSS Prevention | Frontend does not use `bypassSecurityTrustHtml`; chart titles are stripped of HTML |

---

## CI Pipeline

GitHub Actions runs on every push or pull request to `main` and `develop`:

| Job | What it checks |
| :--- | :--- |
| `backend-ci` | Runs all JUnit tests via `./mvnw clean test` |
| `frontend-ci` | Validates production build via `npm run build` |
| `ai-service-ci` | Runs `pytest tests/` against AI agent logic |

See [`.github/workflows/ci.yml`](./.github/workflows/ci.yml).

---

## Default Test Accounts

Pre-loaded by `init.sql`:

| Role | Email | Password |
| :--- | :--- | :--- |
| Admin | `testadmin.panel@example.com` | `Test1234!` |
| Seller | `testseller.panel@example.com` | `Test1234!` |
| Customer | Any registered user | Whatever they set |

---

*Developed by Berk Kocabörek*
