#!/bin/bash

# Update Employee - PUT /api/v1/employees/{id}
# Usage: ./update-employee.sh [employee_id]

API_BASE_URL="http://localhost:8081/api/v1/employees"

# Check if employee ID is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <employee_id>"
    echo "Example: $0 1"
    exit 1
fi

EMPLOYEE_ID=$1

echo "Updating employee with ID: $EMPLOYEE_ID..."

curl -X PUT "$API_BASE_URL/$EMPLOYEE_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe.updated@company.com",
    "phone": "+1-555-0999",
    "department": "Engineering",
    "position": "Principal Software Engineer",
    "salary": 125000.00,
    "hireDate": "2024-01-15",
    "managerId": null,
    "isActive": true
  }' | jq .