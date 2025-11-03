# Employee Management API - CURL Test Scripts

This directory contains comprehensive CURL scripts to test all the REST API endpoints of the Employee Management System.

## Prerequisites

1. **Start the Spring Boot Application**: 
   ```bash
   cd /home/prani/react-dev-learn-with-ai/react-crud-dev/backend
   mvn spring-boot:run
   ```
   
2. **Install jq** (for pretty JSON formatting):
   ```bash
   sudo apt-get install jq
   ```

## Available Scripts

### 1. Complete Test Suite
- **File**: `test-all-endpoints.sh`
- **Description**: Runs all API tests in sequence
- **Usage**: 
  ```bash
  ./test-all-endpoints.sh
  ```

### 2. Individual Operation Scripts

#### Health Check
- **File**: `health-check.sh`
- **Endpoint**: `GET /api/v1/employees/health`
- **Usage**: 
  ```bash
  ./health-check.sh
  ```

#### Create Employee
- **File**: `create-employee.sh`
- **Endpoint**: `POST /api/v1/employees`
- **Usage**: 
  ```bash
  ./create-employee.sh
  ```

#### Get All Employees
- **File**: `get-all-employees.sh`
- **Endpoint**: `GET /api/v1/employees`
- **Usage**: 
  ```bash
  ./get-all-employees.sh
  ```

#### Get Employee by ID
- **File**: `get-employee-by-id.sh`
- **Endpoint**: `GET /api/v1/employees/{id}`
- **Usage**: 
  ```bash
  ./get-employee-by-id.sh 1
  ```

#### Update Employee
- **File**: `update-employee.sh`
- **Endpoint**: `PUT /api/v1/employees/{id}`
- **Usage**: 
  ```bash
  ./update-employee.sh 1
  ```

#### Delete Employee
- **File**: `delete-employee.sh`
- **Endpoint**: `DELETE /api/v1/employees/{id}`
- **Usage**: 
  ```bash
  ./delete-employee.sh 1
  ```

#### Get Employees with Pagination
- **File**: `get-employees-paginated.sh`
- **Endpoint**: `GET /api/v1/employees/paginated`
- **Usage**: 
  ```bash
  ./get-employees-paginated.sh [page] [size] [sortBy] [sortDirection]
  # Examples:
  ./get-employees-paginated.sh 0 5 firstName asc
  ./get-employees-paginated.sh 1 10 salary desc
  ```

#### Get Employees by Department
- **File**: `get-employees-by-department.sh`
- **Endpoint**: `GET /api/v1/employees/department/{department}`
- **Usage**: 
  ```bash
  ./get-employees-by-department.sh Engineering
  ./get-employees-by-department.sh "Human Resources"
  ```

#### Search Employees
- **File**: `search-employees.sh`
- **Endpoint**: `POST /api/v1/employees/search`
- **Usage**: 
  ```bash
  ./search-employees.sh
  ```

## API Endpoints Summary

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/employees/health` | Health check |
| GET | `/api/v1/employees` | Get all employees |
| GET | `/api/v1/employees/paginated` | Get employees with pagination |
| GET | `/api/v1/employees/{id}` | Get employee by ID |
| GET | `/api/v1/employees/department/{dept}` | Get employees by department |
| POST | `/api/v1/employees` | Create new employee |
| POST | `/api/v1/employees/search` | Search employees with criteria |
| PUT | `/api/v1/employees/{id}` | Update employee |
| DELETE | `/api/v1/employees/{id}` | Delete employee (soft delete) |

## Employee Data Model

```json
{
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "phone": "string",
  "department": "string",
  "position": "string",
  "salary": "number",
  "hireDate": "YYYY-MM-DD",
  "managerId": "number or null",
  "isActive": "boolean"
}
```

## Response Format

All API responses follow this format:

```json
{
  "success": boolean,
  "message": "string",
  "data": "object or array",
  "error": "string (only on errors)",
  "timestamp": "ISO datetime string"
}
```

## Testing Workflow

1. Start with health check: `./health-check.sh`
2. Run the complete test suite: `./test-all-endpoints.sh`
3. Or test individual operations as needed

## Common HTTP Status Codes

- **200 OK**: Successful GET, PUT, DELETE
- **201 Created**: Successful POST (create)
- **400 Bad Request**: Validation errors, invalid data
- **404 Not Found**: Employee not found
- **409 Conflict**: Duplicate email or other conflicts
- **500 Internal Server Error**: Server error

## Examples

### Create a new employee:
```bash
curl -X POST "http://localhost:8080/api/v1/employees" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@company.com",
    "phone": "+1-555-0101",
    "department": "Engineering",
    "position": "Software Engineer",
    "salary": 75000.00,
    "hireDate": "2024-01-15",
    "isActive": true
  }'
```

### Search employees:
```bash
curl -X POST "http://localhost:8080/api/v1/employees/search" \
  -H "Content-Type: application/json" \
  -d '{
    "department": "Engineering",
    "minSalary": 70000,
    "maxSalary": 100000,
    "page": 0,
    "size": 10
  }'
```

## Troubleshooting

1. **Connection refused**: Make sure the Spring Boot app is running on port 8080
2. **404 errors**: Check the endpoint URLs and make sure they match the controller mappings
3. **Validation errors**: Check the request payload format and required fields
4. **Database errors**: Ensure PostgreSQL is running and configured properly

## Notes

- All DELETE operations are soft deletes (sets isActive = false)
- Email addresses must be unique across all employees
- Salary must be a positive decimal number
- Date format should be YYYY-MM-DD
- Phone numbers are optional but validated if provided