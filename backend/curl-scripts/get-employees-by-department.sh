#!/bin/bash

# Get Employees by Department - GET /api/v1/employees/department/{department}
# Usage: ./get-employees-by-department.sh [department_name]

API_BASE_URL="http://localhost:8081/api/v1/employees"

# Check if department is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <department_name>"
    echo "Example: $0 Engineering"
    echo "Example: $0 'Human Resources'"
    exit 1
fi

DEPARTMENT=$1

echo "Fetching employees in department: $DEPARTMENT..."

# URL encode the department name
ENCODED_DEPARTMENT=$(echo "$DEPARTMENT" | sed 's/ /%20/g')

curl -X GET "$API_BASE_URL/department/$ENCODED_DEPARTMENT" \
  -H "Content-Type: application/json" | jq .