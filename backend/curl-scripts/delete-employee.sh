#!/bin/bash

# Delete Employee - DELETE /api/v1/employees/{id}
# Usage: ./delete-employee.sh [employee_id]

API_BASE_URL="http://localhost:8081/api/v1/employees"

# Check if employee ID is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <employee_id>"
    echo "Example: $0 1"
    exit 1
fi

EMPLOYEE_ID=$1

echo "Deleting employee with ID: $EMPLOYEE_ID..."
echo "Warning: This is a soft delete operation."

curl -X DELETE "$API_BASE_URL/$EMPLOYEE_ID" \
  -H "Content-Type: application/json" | jq .