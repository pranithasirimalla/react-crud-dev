# Backend - Node.js/Express API

This directory will contain the Express.js backend API for the employee management system.

## 🚀 Getting Started

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn
- PostgreSQL database (use Docker setup from ../database)

### Installation
```bash
# Initialize npm project
npm init -y

# Install dependencies
npm install express cors dotenv pg
npm install -D nodemon

# Install additional utilities
npm install helmet morgan express-rate-limit
```

## 📋 Planned Features

### API Endpoints
```
GET    /api/employees          # Get all employees
GET    /api/employees/:id      # Get employee by ID
POST   /api/employees          # Create new employee
PUT    /api/employees/:id      # Update employee
DELETE /api/employees/:id      # Delete employee (soft delete)
GET    /api/employees/search   # Search employees
GET    /api/departments        # Get all departments
```

### Middleware
- **CORS** - Cross-origin resource sharing
- **Helmet** - Security headers
- **Morgan** - Request logging
- **Rate Limiting** - API rate limiting
- **Error Handling** - Centralized error handling
- **Validation** - Input validation and sanitization

## 🗄️ Database Integration

### Connection Configuration
```javascript
// config/database.js
const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'employee_db',
  user: process.env.DB_USER || 'admin',
  password: process.env.DB_PASSWORD || 'admin123',
});
```

### Environment Variables
Create `.env` file:
```
PORT=3001
DB_HOST=localhost
DB_PORT=5432
DB_NAME=employee_db
DB_USER=admin
DB_PASSWORD=admin123
NODE_ENV=development
```

## 📂 Planned Structure

```
src/
├── config/
│   ├── database.js
│   └── config.js
├── controllers/
│   └── employeeController.js
├── middleware/
│   ├── errorHandler.js
│   ├── validation.js
│   └── auth.js
├── models/
│   └── Employee.js
├── routes/
│   └── employees.js
├── utils/
│   ├── logger.js
│   └── helpers.js
├── tests/
│   └── employees.test.js
├── app.js
└── server.js
```

## 🔒 Security Features

- Input validation and sanitization
- SQL injection prevention
- XSS protection
- Rate limiting
- CORS configuration
- Security headers (Helmet)
- Error handling without exposing internals

## 📊 Sample Controller

```javascript
// controllers/employeeController.js
const getAllEmployees = async (req, res) => {
  try {
    const query = `
      SELECT id, first_name, last_name, email, department, position, salary
      FROM employees 
      WHERE is_active = true 
      ORDER BY last_name, first_name
    `;
    const result = await pool.query(query);
    res.json({
      success: true,
      data: result.rows,
      count: result.rows.length
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error fetching employees',
      error: error.message
    });
  }
};
```

## 🧪 Testing

### Test Setup
```bash
npm install -D jest supertest
```

### Sample Test
```javascript
// tests/employees.test.js
const request = require('supertest');
const app = require('../app');

describe('Employee API', () => {
  test('GET /api/employees should return all employees', async () => {
    const response = await request(app).get('/api/employees');
    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
  });
});
```

## 📋 Package.json Scripts

```json
{
  "scripts": {
    "start": "node src/server.js",
    "dev": "nodemon src/server.js",
    "test": "jest",
    "test:watch": "jest --watch"
  }
}
```

## 🔄 API Response Format

### Success Response
```json
{
  "success": true,
  "data": [...],
  "message": "Operation completed successfully",
  "count": 10
}
```

### Error Response
```json
{
  "success": false,
  "message": "Error description",
  "error": "Detailed error information"
}
```

---

*This backend will provide a robust, secure API for the employee management system.*