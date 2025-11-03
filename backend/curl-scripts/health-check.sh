#!/bin/bash

# Health Check - GET /api/v1/employees/health
# Usage: ./health-check.sh

API_BASE_URL="http://localhost:8081/api/v1/employees"

echo "Checking API health..."

curl -X GET "$API_BASE_URL/health" \
  -H "Content-Type: application/json" | jq .