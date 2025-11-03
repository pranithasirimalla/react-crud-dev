# Employee Management API - Postman Collections

This directory contains comprehensive Postman collections for testing the Employee Management REST API built with Spring Boot 3.2.0 and Java 21.

## 📁 Collection Files

### 1. `Employee-Management-API.postman_collection.json`
**Main Collection** - Complete set of API endpoints organized by functionality:

- **Health & System**: Health check, Swagger UI access, OpenAPI specification
- **Employee CRUD Operations**: Create, Read, Update, Delete operations
- **Employee Search & Filtering**: Pagination, search, department/position/manager filters
- **Department & Position Operations**: Get all departments and positions
- **Test Data & Validation**: Validation error testing, duplicate handling, 404 scenarios

### 2. `Employee-Management-TestSuite.postman_collection.json`
**Automated Test Suite** - End-to-end workflow testing with:

- Pre-request scripts for setup
- Comprehensive test assertions
- Automatic variable management
- Error handling validation
- Complete CRUD workflow validation

### 3. `Employee-Management-Environment.postman_environment.json`
**Environment Configuration** - Variables for easy switching between environments:

- Base URL configuration
- API version management
- Test data IDs
- Common parameters

## 🚀 Getting Started

### Prerequisites
- Postman installed (Desktop or Web version)
- Employee Management API running locally on `http://localhost:8081`
- PostgreSQL database configured and running

### Import Instructions

1. **Open Postman**
2. **Import Collections**:
   - Click "Import" in Postman
   - Select all three `.json` files from this directory
   - Click "Import"

3. **Set Up Environment**:
   - Go to "Environments" in Postman
   - Select "Employee Management API - Local Development"
   - Update variables if your setup differs from defaults

### Basic Usage

#### Option 1: Manual Testing (Main Collection)
1. Select the "Employee Management API" collection
2. Choose "Employee Management API - Local Development" environment
3. Start with "Health Check" to verify API connectivity
4. Use individual endpoints as needed

#### Option 2: Automated Testing (Test Suite)
1. Select the "Employee Management API - Test Suite" collection
2. Choose "Employee Management API - Local Development" environment
3. Click "Run" to execute the entire test suite
4. Review test results in the Collection Runner

## 📋 API Endpoints Overview

### Core CRUD Operations
```
GET    /api/v1/employees/health           # Health check
GET    /api/v1/employees                  # Get all employees
GET    /api/v1/employees/{id}             # Get employee by ID
POST   /api/v1/employees                  # Create employee
PUT    /api/v1/employees/{id}             # Update employee
DELETE /api/v1/employees/{id}             # Delete employee (soft delete)
```

### Search & Filtering
```
GET    /api/v1/employees/paginated        # Paginated employees
POST   /api/v1/employees/search          # Advanced search
GET    /api/v1/employees/department/{dept} # Filter by department
GET    /api/v1/employees/position/{pos}   # Filter by position
GET    /api/v1/employees/manager/{id}     # Filter by manager
```

### Metadata
```
GET    /api/v1/employees/departments      # Get all departments
GET    /api/v1/employees/positions        # Get all positions
```

## 🧪 Test Scenarios Covered

### Positive Tests
- ✅ Employee creation with valid data
- ✅ Employee retrieval by ID
- ✅ Employee updates
- ✅ Employee soft deletion
- ✅ Pagination and sorting
- ✅ Department and position filtering
- ✅ Manager hierarchy queries

### Negative Tests
- ❌ Validation errors (empty fields, invalid email, negative salary)
- ❌ Duplicate email handling
- ❌ Non-existent employee access (404)
- ❌ Invalid data format handling
- ❌ Accessing deleted employees

### Performance Tests
- ⏱️ Response time validation (< 2 seconds)
- 📊 Pagination efficiency
- 🔍 Search performance

## 📊 Sample Test Data

### Valid Employee Data
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@company.com",
  "phone": "+1-555-0101",
  "department": "Engineering",
  "position": "Senior Software Engineer",
  "salary": 95000.00,
  "hireDate": "2024-01-15",
  "managerId": 2,
  "isActive": true
}
```

### Search Request Example
```json
{
  "searchTerm": "john",
  "department": "Engineering",
  "position": null,
  "page": 0,
  "size": 10,
  "sortBy": "firstName",
  "sortDirection": "asc"
}
```

## 🔧 Environment Variables

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `baseUrl` | `http://localhost:8081/api` | API base URL |
| `apiVersion` | `v1` | API version |
| `testEmployeeId` | `1` | Employee ID for testing |
| `testManagerId` | `2` | Manager ID for hierarchy tests |
| `testDepartment` | `Engineering` | Department for filtering |
| `testPosition` | `Software Engineer` | Position for filtering |

## 📈 Expected Test Results

When running the complete test suite, you should expect:

- **10 test requests** executed
- **25+ individual test assertions** validated
- **Success rate**: 100% (when API is healthy)
- **Total execution time**: < 5 seconds

### Test Sequence
1. System health verification
2. Employee creation and validation
3. Employee retrieval confirmation
4. Employee update operations
5. Pagination functionality
6. Department filtering
7. Validation error handling
8. 404 error handling
9. Employee deletion (soft delete)
10. Deletion verification

## 🐛 Troubleshooting

### Common Issues

1. **Connection Refused**
   - Ensure API is running on `http://localhost:8081`
   - Check if PostgreSQL database is accessible
   - Verify application.yml configuration

2. **404 Errors**
   - Confirm API context path is `/api`
   - Check controller mapping is `/v1/employees`
   - Verify Swagger UI at `http://localhost:8081/api/swagger-ui.html`

3. **Validation Failures**
   - Review employee data constraints in `EmployeeRequest.java`
   - Check database schema requirements
   - Validate email format and unique constraints

4. **Database Connection Issues**
   - Ensure PostgreSQL container is running
   - Check database credentials in `application.yml`
   - Verify database schema exists

### Debug Steps
1. Run "Health Check" endpoint first
2. Check Postman console for detailed error messages
3. Review API logs for backend errors
4. Verify environment variables are set correctly
5. Test individual endpoints before running full suite

## 🔗 Related Resources

- **Swagger UI**: `http://localhost:8081/api/swagger-ui.html`
- **OpenAPI Spec**: `http://localhost:8081/api/v3/api-docs`
- **Database Admin**: `http://localhost:5050` (pgAdmin)
- **Curl Scripts**: `../testing-scripts/` directory

## 📝 Notes

- All collections support both Postman Desktop and Web versions
- Environment variables make it easy to switch between development, staging, and production
- Test suite can be integrated into CI/CD pipelines using Newman (Postman CLI)
- Collections are compatible with Postman Collection Format v2.1.0

## 🤝 Contributing

When adding new endpoints or modifying existing ones:
1. Update the main collection with new requests
2. Add corresponding test scenarios to the test suite
3. Update environment variables if needed
4. Refresh this README with new endpoints or procedures

---

**Last Updated**: December 2024  
**API Version**: v1  
**Postman Collection Format**: v2.1.0