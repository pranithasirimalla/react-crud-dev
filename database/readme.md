# PostgreSQL Database Setup Guide

## Overview
This document outlines the setup and configuration of a PostgreSQL database environment using Docker Compose with a web-based UI for database management.

## Project Structure
```
database/
├── docker-compose.yml           # Docker services configuration
├── data/                       # Persistent data storage
├── schema/                     # Database schema files
│   └── employee.sql
├── seed-data/                  # Initial data files
│   └── employee-data.sql
├── sql-scripts/                # CRUD operation scripts
│   ├── employee_crud_operations.sql  # Comprehensive CRUD operations
│   ├── react_crud_queries.sql       # React app focused queries
│   ├── test_queries.sql             # Quick test queries
│   └── README.md                    # SQL scripts documentation
├── start-db.sh                 # Start database services
├── stop-db.sh                  # Stop database services  
├── status-db.sh                # Check service status
├── restart-db.sh               # Restart database services
├── PGADMIN_CONNECTION_GUIDE.md  # pgAdmin connection instructions
├── SETUP_COMPLETE.md           # Setup completion summary
├── SCRIPTS_GUIDE.md            # Management scripts guide
└── readme.md                   # This file
```

## Services Configuration

### 1. PostgreSQL Database Service
- **Service Name**: `postgresdb`
- **Purpose**: Main PostgreSQL database server
- **Features**:
  - Persistent data storage in `data/` folder
  - Automatic database initialization
  - Employee database creation on startup

### 2. PostgreSQL Web UI Service
- **Service Name**: `postgresui`
- **Purpose**: Web-based database management interface
- **Features**:
  - Connect to PostgreSQL database
  - Visual database management
  - Query execution interface

## Setup Instructions

### 1. Docker Compose Setup
Create a `docker-compose.yml` file with the following services:
- PostgreSQL database server
- PostgreSQL web UI (pgAdmin or similar)
- Network configuration for service communication

### 2. Directory Structure Creation
Create the following directories:
```bash
mkdir -p data schema seed-data
```

### 3. Database Schema
- Create `schema/employee.sql` with employee table definition
- Include all necessary columns, constraints, and indexes

### 4. Seed Data
- Create `seed-data/employee-data.sql` with sample employee records
- Ensure data follows the schema structure

## Deployment Process

### Startup Sequence
1. **Docker Compose Start**: Run `docker-compose up -d`
2. **PostgreSQL Initialization**: Database server starts and creates employee database
3. **Schema Application**: Employee table schema is applied automatically
4. **Data Seeding**: Sample employee data is inserted
5. **UI Connection**: Web UI connects to PostgreSQL database

### Data Persistence
- All database changes are persisted to the `data/` folder
- Data survives container restarts and updates

## Database Access Guide

### Connecting to PostgreSQL UI
1. **Access URL**: Open web browser to UI service endpoint
2. **Login Credentials**: Use configured database credentials
3. **Database Connection**: Connect to the PostgreSQL server
4. **Database Selection**: Select the employee database

### Using the Database Interface
1. **Browse Tables**: Navigate to employee table
2. **Execute Queries**: Run SQL queries for CRUD operations
3. **Data Management**: Insert, update, delete employee records
4. **Schema Viewing**: Examine table structure and relationships

### Best Practices
- Always backup data before major changes
- Use transactions for multiple related operations
- Regularly monitor database performance
- Keep schema and seed data files updated

## Management Scripts

The project includes convenient scripts for managing the database services:

### 🚀 start-db.sh
```bash
./start-db.sh
```
- Starts PostgreSQL and pgAdmin services
- Performs health checks
- Displays service information and connection details
- Shows helpful usage tips

### 🛑 stop-db.sh
```bash
./stop-db.sh
```
- Gracefully stops all services
- Preserves data in volumes
- Provides cleanup confirmation
- Shows data persistence information

### 📊 status-db.sh
```bash
./status-db.sh
```
- Shows current service status
- Tests database connectivity
- Displays employee record count
- Lists available management commands

### 🔄 restart-db.sh
```bash
./restart-db.sh
```
- Performs clean restart of all services
- Stops services gracefully, then restarts
- Includes proper wait intervals

## Docker Compose Commands

For manual control, you can also use standard Docker Compose commands:
- **Start services**: `docker compose up -d`
- **Stop services**: `docker compose down`
- **View logs**: `docker compose logs -f`
- **View PostgreSQL logs**: `docker compose logs -f postgresdb`
- **View pgAdmin logs**: `docker compose logs -f postgresui`
- **Rebuild services**: `docker compose up -d --build`

## Troubleshooting
- Check Docker container logs for startup issues
- Verify network connectivity between services
- Ensure proper file permissions for data directory
- Validate SQL syntax in schema and seed files