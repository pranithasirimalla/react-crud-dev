#!/bin/bash

# Get Employee by ID - GET /api/v1/employees/{id}
# Usage: ./get-employee-by-id.sh [employee_id]

API_BASE_URL="http://localhost:8081/api/v1/employees"

# Check if employee ID is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <employee_id>"
    echo "Example: $0 1"
    exit 1
fi

EMPLOYEE_ID=$1

echo "Fetching employee with ID: $EMPLOYEE_ID..."

curl -X GET "$API_BASE_URL/$EMPLOYEE_ID" \
  -H "Content-Type: application/json" | jq .