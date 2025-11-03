#!/bin/bash

# Get Employees with Pagination - GET /api/v1/employees/paginated
# Usage: ./get-employees-paginated.sh [page] [size] [sortBy] [sortDirection]

API_BASE_URL="http://localhost:8081/api/v1/employees"

# Default values
PAGE=${1:-0}
SIZE=${2:-10}
SORT_BY=${3:-"firstName"}
SORT_DIRECTION=${4:-"asc"}

echo "Fetching employees with pagination..."
echo "Page: $PAGE, Size: $SIZE, Sort By: $SORT_BY, Direction: $SORT_DIRECTION"

curl -X GET "$API_BASE_URL/paginated?page=$PAGE&size=$SIZE&sortBy=$SORT_BY&sortDirection=$SORT_DIRECTION" \
  -H "Content-Type: application/json" | jq .