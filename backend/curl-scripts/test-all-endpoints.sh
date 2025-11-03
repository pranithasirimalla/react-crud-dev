#!/bin/bash

# Employee Management API - CRUD Operations Test Scripts
# Make sure the Spring Boot application is running on http://localhost:8081

API_BASE_URL="http://localhost:8081/api/v1/employees"

echo "==================================="
echo "Employee Management API Test Suite"
echo "==================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print test headers
print_test() {
    echo -e "${BLUE}=== $1 ===${NC}"
}

# Function to print success
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Function to print error
print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Function to print info
print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Test 1: Health Check
print_test "1. Health Check"
echo "GET $API_BASE_URL/health"
curl -s -X GET "$API_BASE_URL/health" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

# Test 2: Get all employees (should be empty initially)
print_test "2. Get All Employees (Initial - should be empty)"
echo "GET $API_BASE_URL"
curl -s -X GET "$API_BASE_URL" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

# Test 3: Create Employee 1
print_test "3. Create Employee 1 - John Doe"
echo "POST $API_BASE_URL"
curl -s -X POST "$API_BASE_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@company.com",
    "phone": "+1-555-0101",
    "department": "Engineering",
    "position": "Senior Software Engineer",
    "salary": 95000.00,
    "hireDate": "2024-01-15",
    "managerId": null,
    "isActive": true
  }' | jq .
echo -e "\n"

# Test 4: Create Employee 2
print_test "4. Create Employee 2 - Jane Smith"
echo "POST $API_BASE_URL"
curl -s -X POST "$API_BASE_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Jane",
    "lastName": "Smith",
    "email": "jane.smith@company.com",
    "phone": "+1-555-0102",
    "department": "Marketing",
    "position": "Marketing Manager",
    "salary": 78000.00,
    "hireDate": "2024-02-01",
    "managerId": null,
    "isActive": true
  }' | jq .
echo -e "\n"

# Test 5: Create Employee 3
print_test "5. Create Employee 3 - Mike Johnson"
echo "POST $API_BASE_URL"
curl -s -X POST "$API_BASE_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Mike",
    "lastName": "Johnson",
    "email": "mike.johnson@company.com",
    "phone": "+1-555-0103",
    "department": "Engineering",
    "position": "Software Engineer",
    "salary": 72000.00,
    "hireDate": "2024-03-10",
    "managerId": 1,
    "isActive": true
  }' | jq .
echo -e "\n"

# Test 6: Get all employees (should now have data)
print_test "6. Get All Employees (After Creation)"
echo "GET $API_BASE_URL"
curl -s -X GET "$API_BASE_URL" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

# Test 7: Get employee by ID
print_test "7. Get Employee by ID (ID: 1)"
echo "GET $API_BASE_URL/1"
curl -s -X GET "$API_BASE_URL/1" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

# Test 8: Update employee
print_test "8. Update Employee (ID: 1) - Salary Increase"
echo "PUT $API_BASE_URL/1"
curl -s -X PUT "$API_BASE_URL/1" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@company.com",
    "phone": "+1-555-0101",
    "department": "Engineering",
    "position": "Lead Software Engineer",
    "salary": 110000.00,
    "hireDate": "2024-01-15",
    "managerId": null,
    "isActive": true
  }' | jq .
echo -e "\n"

# Test 9: Get employees with pagination
print_test "9. Get Employees with Pagination (page=0, size=2)"
echo "GET $API_BASE_URL/paginated?page=0&size=2&sortBy=firstName&sortDirection=asc"
curl -s -X GET "$API_BASE_URL/paginated?page=0&size=2&sortBy=firstName&sortDirection=asc" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

# Test 10: Get employees by department
print_test "10. Get Employees by Department (Engineering)"
echo "GET $API_BASE_URL/department/Engineering"
curl -s -X GET "$API_BASE_URL/department/Engineering" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

# Test 11: Search employees
print_test "11. Search Employees (Department: Engineering)"
echo "POST $API_BASE_URL/search"
curl -s -X POST "$API_BASE_URL/search" \
  -H "Content-Type: application/json" \
  -d '{
    "department": "Engineering",
    "page": 0,
    "size": 10,
    "sortBy": "firstName",
    "sortDirection": "asc"
  }' | jq .
echo -e "\n"

# Test 12: Delete employee (soft delete)
print_test "12. Delete Employee (ID: 3) - Soft Delete"
echo "DELETE $API_BASE_URL/3"
curl -s -X DELETE "$API_BASE_URL/3" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

# Test 13: Try to get deleted employee
print_test "13. Try to Get Deleted Employee (ID: 3)"
echo "GET $API_BASE_URL/3"
curl -s -X GET "$API_BASE_URL/3" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

# Test 14: Validation Error Test - Missing required fields
print_test "14. Validation Error Test - Missing Required Fields"
echo "POST $API_BASE_URL"
curl -s -X POST "$API_BASE_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "",
    "email": "invalid-email",
    "department": "",
    "salary": -1000
  }' | jq .
echo -e "\n"

# Test 15: Duplicate Email Test
print_test "15. Duplicate Email Test"
echo "POST $API_BASE_URL"
curl -s -X POST "$API_BASE_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Test",
    "lastName": "User",
    "email": "john.doe@company.com",
    "department": "IT",
    "position": "Developer",
    "salary": 50000
  }' | jq .
echo -e "\n"

# Test 16: Invalid ID Test
print_test "16. Invalid ID Test (Non-existent ID: 999)"
echo "GET $API_BASE_URL/999"
curl -s -X GET "$API_BASE_URL/999" \
  -H "Content-Type: application/json" | jq .
echo -e "\n"

print_success "All tests completed!"
print_info "Check the responses above to verify the API is working correctly."