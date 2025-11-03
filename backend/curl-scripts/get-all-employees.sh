#!/bin/bash

# Get All Employees - GET /api/v1/employees
# Usage: ./get-all-employees.sh

API_BASE_URL="http://localhost:8081/api/v1/employees"

echo "Fetching all employees..."

curl -X GET "$API_BASE_URL" \
  -H "Content-Type: application/json" | jq .