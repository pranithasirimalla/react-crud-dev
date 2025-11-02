# React CRUD Application with PostgreSQL

A full-stack CRUD (Create, Read, Update, Delete) application built with React frontend, Node.js/Express backend, and PostgreSQL database. This project demonstrates modern web development practices with Docker containerization.

## 🚀 Project Overview

This project is a complete employee management system featuring:
- **React Frontend** - Modern UI for employee management
- **Node.js/Express Backend** - RESTful API with proper error handling
- **PostgreSQL Database** - Robust data storage with proper schema design
- **Docker Setup** - Containerized database with pgAdmin for easy development
- **Management Scripts** - Convenient bash scripts for database operations

## 📁 Project Structure

```
react-crud-dev/
├── frontend/                    # React application
├── backend/                     # Node.js/Express API
├── database/                    # PostgreSQL setup and scripts
│   ├── docker-compose.yml       # Docker services configuration
│   ├── schema/                  # Database schema files
│   ├── seed-data/              # Initial sample data
│   ├── sql-scripts/            # CRUD operation scripts
│   ├── start-db.sh             # Start database services
│   ├── stop-db.sh              # Stop database services
│   ├── status-db.sh            # Check service status
│   └── restart-db.sh           # Restart database services
├── .gitignore                  # Git ignore rules
└── README.md                   # This file
```

## 🛠️ Technologies Used

### Frontend
- **React** - UI library for building user interfaces
- **React Router** - Client-side routing
- **Axios** - HTTP client for API requests
- **CSS Modules** - Scoped CSS styling

### Backend  
- **Node.js** - JavaScript runtime
- **Express.js** - Web framework
- **PostgreSQL** - Relational database
- **CORS** - Cross-origin resource sharing
- **dotenv** - Environment variable management

### Database & DevOps
- **PostgreSQL 15** - Primary database
- **pgAdmin 4** - Database administration tool
- **Docker & Docker Compose** - Containerization
- **Git** - Version control

## 🚀 Quick Start

### Prerequisites
- Docker Desktop installed and running
- WSL integration enabled (for Windows users)
- Git installed

### 1. Clone Repository
```bash
git clone <repository-url>
cd react-crud-dev
```

### 2. Start Database Services
```bash
cd database
./start-db.sh
```

### 3. Access Database UI
- **pgAdmin URL**: http://localhost:8080
- **Email**: admin@example.com
- **Password**: admin123

### 4. Database Connection (in pgAdmin)
- **Host**: postgresdb
- **Port**: 5432
- **Database**: employee_db
- **Username**: admin
- **Password**: admin123

## 📊 Database Features

### Employee Management Schema
The database includes a comprehensive employee table with:
- Personal information (name, email, phone)
- Work details (department, position, salary)
- Organizational hierarchy (manager relationships)
- Audit fields (created_at, updated_at)
- Soft delete capability (is_active flag)

### Sample Data
- **21 sample employees** across 5 departments
- **Realistic organizational structure** with CEO → Managers → Staff
- **Complete hierarchy** for testing relationship queries

### Departments Included
- **Executive** (1 employee) - CEO level
- **Engineering** (6 employees) - Developers, DevOps, QA
- **Sales** (5 employees) - Sales reps, Account executives
- **Marketing** (4 employees) - Digital marketing, Content creation
- **HR** (3 employees) - HR specialists, Recruiters

## 🔧 Database Management

### Management Scripts
```bash
# Start all services
./start-db.sh

# Check service status  
./status-db.sh

# Stop all services
./stop-db.sh

# Restart services
./restart-db.sh
```

### SQL Scripts Available
- **`employee_crud_operations.sql`** - Comprehensive CRUD examples
- **`react_crud_queries.sql`** - Ready-to-use queries for React app
- **`test_queries.sql`** - Quick test queries for pgAdmin

## 🎯 Development Roadmap

### Phase 1: Database Setup ✅
- [x] PostgreSQL Docker setup
- [x] Employee table schema
- [x] Sample data insertion
- [x] pgAdmin configuration
- [x] Management scripts
- [x] CRUD SQL scripts

### Phase 2: Backend API (Next)
- [ ] Express.js server setup
- [ ] Database connection configuration
- [ ] RESTful API endpoints
- [ ] Error handling middleware
- [ ] Input validation
- [ ] API documentation

### Phase 3: Frontend Application (Future)
- [ ] React application setup
- [ ] Component structure
- [ ] API integration
- [ ] Form handling
- [ ] State management
- [ ] UI/UX design

### Phase 4: Testing & Deployment (Future)
- [ ] Unit tests
- [ ] Integration tests
- [ ] Docker setup for full stack
- [ ] CI/CD pipeline
- [ ] Documentation

## 📋 API Endpoints (Planned)

### Employee Management
```
GET    /api/employees          # Get all employees
GET    /api/employees/:id      # Get employee by ID
POST   /api/employees          # Create new employee
PUT    /api/employees/:id      # Update employee
DELETE /api/employees/:id      # Delete employee (soft delete)
```

### Additional Endpoints
```
GET    /api/employees/search?q=term    # Search employees
GET    /api/departments                # Get all departments
GET    /api/employees/department/:name # Get employees by department
```

## 🔌 Connection Information

### Database Access
- **External Host**: localhost:5432
- **Internal Host**: postgresdb:5432
- **Database**: employee_db
- **Username**: admin
- **Password**: admin123

### pgAdmin Access
- **URL**: http://localhost:8080
- **Login Email**: admin@example.com
- **Login Password**: admin123

## 🧪 Testing Your Setup

### 1. Verify Database Connection
```bash
cd database
./status-db.sh
```

### 2. Test Sample Queries
Open pgAdmin and run queries from `database/sql-scripts/test_queries.sql`

### 3. Explore Data
```sql
-- View all employees with their managers
SELECT 
    e.first_name || ' ' || e.last_name as employee,
    e.department, e.position, e.salary,
    COALESCE(m.first_name || ' ' || m.last_name, 'CEO') as manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
WHERE e.is_active = true
ORDER BY e.department, e.salary DESC;
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Troubleshooting

### Docker Issues
- Ensure Docker Desktop is running
- Enable WSL integration in Docker settings (Windows users)
- Check port 5432 and 8080 are not in use by other services

### Database Connection Issues
- Verify services are running: `./status-db.sh`
- Restart services: `./restart-db.sh`
- Check Docker logs: `docker compose logs`

### pgAdmin Access Issues
- Wait for services to fully start (about 10-15 seconds)
- Clear browser cache if login issues persist
- Verify URL: http://localhost:8080

## 📞 Support

For issues and questions:
1. Check the troubleshooting section above
2. Review the documentation in each directory
3. Check Docker and service logs
4. Create an issue in the repository

---

**Happy Coding! 🚀**

*This project demonstrates modern full-stack development practices with React, Node.js, and PostgreSQL.*