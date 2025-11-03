#!/bin/bash

# Search Employees - POST /api/v1/employees/search
# Usage: ./search-employees.sh

API_BASE_URL="http://localhost:8081/api/v1/employees"

echo "Searching employees with criteria..."

curl -X POST "$API_BASE_URL/search" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "",
    "lastName": "",
    "email": "",
    "department": "Engineering",
    "position": "",
    "minSalary": 70000,
    "maxSalary": 150000,
    "startHireDate": null,
    "endHireDate": null,
    "isActive": true,
    "managerId": null,
    "page": 0,
    "size": 10,
    "sortBy": "salary",
    "sortDirection": "desc"
  }' | jq .