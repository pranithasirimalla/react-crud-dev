# SQL Scripts for Employee CRUD Operations

This directory contains SQL scripts for performing CRUD operations on the employee table.

## 📁 Files Overview

| File | Purpose | Use Case |
|------|---------|----------|
| `employee_crud_operations.sql` | Comprehensive CRUD operations | Learning, reference, advanced operations |
| `react_crud_queries.sql` | React app focused queries | Copy-paste into your React/Node.js application |
| `test_queries.sql` | Quick test queries | Run in pgAdmin to explore your data |

## 🚀 Quick Start

### 1. Test Your Database
Open pgAdmin and run queries from `test_queries.sql` to explore your employee data.

### 2. For React Development  
Use `react_crud_queries.sql` - these are optimized for web applications with proper formatting for API endpoints.

### 3. Advanced Operations
Refer to `employee_crud_operations.sql` for complex queries, bulk operations, and data analysis.

## 📋 Common Operations

### Create Employee
```sql
INSERT INTO employees (first_name, last_name, email, phone, department, position, salary)
VALUES ('John', 'Doe', 'john.doe@company.com', '+1-555-0100', 'Engineering', 'Developer', 75000);
```

### Read Employees
```sql
SELECT id, first_name, last_name, email, department, position, salary 
FROM employees 
WHERE is_active = true 
ORDER BY last_name;
```

### Update Employee  
```sql
UPDATE employees 
SET salary = 80000, position = 'Senior Developer', updated_at = CURRENT_TIMESTAMP
WHERE id = 1;
```

### Delete Employee (Soft)
```sql
UPDATE employees 
SET is_active = false, updated_at = CURRENT_TIMESTAMP
WHERE id = 1;
```

## 🔍 Testing Queries in pgAdmin

1. **Connect to your database** using the connection guide
2. **Open Query Tool** (right-click on `employee_db`)
3. **Copy queries** from the SQL files
4. **Execute** to see results

## 💡 API Integration Tips

### For Node.js/Express:
```javascript
// Example using the queries in your API
const getEmployees = async () => {
  const query = `
    SELECT id, first_name, last_name, email, department, position, salary 
    FROM employees 
    WHERE is_active = true 
    ORDER BY last_name
  `;
  return await pool.query(query);
};
```

### For React Frontend:
```javascript
// Example fetch for employee list
const fetchEmployees = async () => {
  const response = await fetch('/api/employees');
  const employees = await response.json();
  return employees;
};
```

## 📊 Sample Data Available

Your database contains **21 sample employees** across these departments:
- **Executive** (1 employee) - CEO
- **Engineering** (5 employees) - Developers, DevOps
- **Sales** (4 employees) - Sales reps, Account executives  
- **Marketing** (3 employees) - Digital marketing, Content
- **HR** (2 employees) - HR specialists, Recruiters

## 🎯 Next Steps

1. ✅ **Test queries** in pgAdmin using `test_queries.sql`
2. 🔧 **Set up your API** using queries from `react_crud_queries.sql`  
3. 🎨 **Build your React frontend** to consume the API
4. 📈 **Add advanced features** using `employee_crud_operations.sql`

## 🔗 Connection Details

Remember your database connection info:
- **Host**: `localhost:5432` (external) or `postgresdb:5432` (internal)
- **Database**: `employee_db`
- **Username**: `admin`
- **Password**: `admin123`