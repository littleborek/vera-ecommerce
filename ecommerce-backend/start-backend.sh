#!/usr/bin/env bash
set -euo pipefail

if [[ -f .env.local ]]; then
  set -a
  # shellcheck disable=SC1091
  source .env.local
  set +a
fi

: "${JWT_SECRET:?JWT_SECRET is required}"
: "${ANALYTICS_INTERNAL_API_KEY:?ANALYTICS_INTERNAL_API_KEY is required}"
: "${STRIPE_PUBLIC_KEY:?STRIPE_PUBLIC_KEY is required}"
: "${STRIPE_SECRET_KEY:?STRIPE_SECRET_KEY is required}"

export STRIPE_SUCCESS_URL="${STRIPE_SUCCESS_URL:-http://localhost:4200/checkout?payment=success}"
export STRIPE_CANCEL_URL="${STRIPE_CANCEL_URL:-http://localhost:4200/checkout?payment=cancel}"
export STRIPE_WEBHOOK_SECRET="${STRIPE_WEBHOOK_SECRET:-}"

exec ./mvnw spring-boot:run
