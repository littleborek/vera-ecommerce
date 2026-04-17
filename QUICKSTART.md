# 🚀 E-Commerce Analytics Platform - Quick Start Guide

This guide describes how to run the entire platform (Frontend, Backend, AI Service, and Database) on any machine using Docker.

## 📋 Prerequisites
Before you begin, ensure you have the following installed:
1. **Docker & Docker Compose**
2. **LM Studio** (For running the AI model locally)

---

## 🛠️ Step-by-Step Setup

### 1. Prepare the AI Model (LM Studio)
The AI Analytics service runs locally for privacy and cost reasons.
1. Open **LM Studio**.
2. Search for and download a compatible model (Recommended: `Mistral-Nemo-12B-Instruct` or `Llama-3.1-8B-Instruct`).
3. Go to the **Local Server** tab (↔️ icon) in LM Studio.
4. Select the downloaded model and click **Start Server**.
5. Ensure the server is running on port `1234`.
6. **Important:** In LM Studio settings, ensure "CORS" is enabled or "Cross-Origin Resource Sharing" is allowed.

### 2. Environment Configuration
The project is pre-configured to work out of the box with Docker. However, if you want to customize secrets:
- Open `docker-compose.yml` to see the default environment variables.
- The `AI_SERVICE` is configured to look for the host machine at `host.docker.internal:1234`.

### 3. Launch the Platform
In the root directory of the project, run:
```bash
docker-compose up --build
```
This command will:
- Spin up a **PostgreSQL 17** database and initialize it with `init.sql`.
- Build and start the **Spring Boot Java Backend** (Port 8080).
- Build and start the **Python LangGraph AI Service** (Port 8000).
- Build and start the **Angular Frontend** (Port 4200).

### 4. Access the Application
Once all containers are running (it may take a few minutes for the first build):
- **Frontend:** [http://localhost:4200](http://localhost:4200)
- **Backend API:** [http://localhost:8080](http://localhost:8080)
- **AI Service:** [http://localhost:8000](http://localhost:8000)

---

## 🔐 Default Credentials (for testing)
You can login with the following accounts (pre-loaded via `init.sql`):

| Role | Username | Password |
| :--- | :--- | :--- |
| **Admin** | admin | password |
| **Seller** | seller | password |
| **Customer** | customer | password |

---

## 🔍 Troubleshooting
- **AI Service Connection Error:** Ensure LM Studio server is started **before** running `docker-compose up`. If you started it later, you might need to restart the `ecommerce_ai_service` container.
- **Database Connection:** If the backend fails to connect to the DB, ensure no other service is using port `5434` or `5432` on your host.
- **Memory:** Building the Spring Boot and Angular apps simultaneously requires at least 4GB of RAM assigned to Docker.
