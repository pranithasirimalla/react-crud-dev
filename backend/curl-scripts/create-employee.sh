#!/bin/bash

# Create Employee - POST /api/v1/employees
# Usage: ./create-employee.sh

API_BASE_URL="http://localhost:8081/api/v1/employees"

echo "Creating a new employee..."

curl -X POST "$API_BASE_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Alice",
    "lastName": "Williams",
    "email": "alice.williams@company.com",
    "phone": "+1-555-0104",
    "department": "Human Resources",
    "position": "HR Manager",
    "salary": 85000.00,
    "hireDate": "2024-04-01",
    "managerId": null,
    "isActive": true
  }' | jq .