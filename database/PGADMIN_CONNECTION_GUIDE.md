# pgAdmin Connection Guide

## 🖥️ Accessing pgAdmin Web Interface

### Step 1: Open pgAdmin
- **URL**: http://localhost:8080
- **Status**: ✅ Already opened in Simple Browser

### Step 2: Login to pgAdmin
Use these credentials to log into pgAdmin:
- **Email**: `admin@example.com`
- **Password**: `admin123`

## 🔌 Connecting pgAdmin to PostgreSQL Database

Once you're logged into pgAdmin, follow these steps to connect to your PostgreSQL database:

### Step 3: Add New Server
1. **Right-click** on "Servers" in the left sidebar
2. **Select** "Register" → "Server..."

### Step 4: Server Connection Details

#### 📋 General Tab:
- **Name**: `Employee Database` (or any name you prefer)

#### 🔌 Connection Tab:
- **Host name/address**: `postgresdb`
- **Port**: `5432`
- **Maintenance database**: `employee_db`
- **Username**: `admin`
- **Password**: `admin123`

#### ⚙️ Advanced Tab (Optional):
- **Save password**: ✅ Check this box to avoid re-entering password

### Step 5: Test & Save
1. **Click** "Save" to create the connection
2. The server should appear in the left sidebar under "Servers"
3. **Expand** the server to see:
   - Databases → employee_db → Schemas → public → Tables → employees

## 📊 Exploring Your Data

### View Employee Table:
1. Navigate to: **Servers** → **Employee Database** → **Databases** → **employee_db** → **Schemas** → **public** → **Tables**
2. **Right-click** on `employees` table
3. **Select** "View/Edit Data" → "All Rows"

### Run Custom Queries:
1. **Right-click** on `employee_db` database
2. **Select** "Query Tool"
3. **Try these sample queries**:

```sql
-- View all employees
SELECT * FROM employees;

-- Count employees by department
SELECT department, COUNT(*) as employee_count 
FROM employees 
WHERE is_active = true 
GROUP BY department 
ORDER BY employee_count DESC;

-- Find all managers
SELECT first_name, last_name, department, position 
FROM employees 
WHERE position LIKE '%Manager%';

-- Employee hierarchy
SELECT 
    e.first_name || ' ' || e.last_name as employee,
    e.position,
    m.first_name || ' ' || m.last_name as manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
WHERE e.is_active = true
ORDER BY e.department, e.position;
```

## 🔧 Troubleshooting

### ❌ Can't Access http://localhost:8080
1. **Check services**: Run `./status-db.sh` in terminal
2. **Restart services**: Run `./restart-db.sh`
3. **Check Docker**: Ensure Docker Desktop is running

### ❌ Can't Connect to PostgreSQL from pgAdmin
- **Verify host**: Use `postgresdb` (NOT `localhost`)
- **Check credentials**: Username: `admin`, Password: `admin123`
- **Check database**: Use `employee_db`

### ❌ "server closed the connection unexpectedly"
1. **Wait a moment**: Database might still be starting up
2. **Check health**: Services should show "healthy" status
3. **Restart**: Use `./restart-db.sh` if needed

## 🎯 Quick Connection Summary

| Setting | Value |
|---------|--------|
| pgAdmin URL | http://localhost:8080 |
| pgAdmin Email | admin@example.com |
| pgAdmin Password | admin123 |
| PostgreSQL Host | postgresdb |
| PostgreSQL Port | 5432 |
| Database Name | employee_db |
| DB Username | admin |
| DB Password | admin123 |

## 🚀 Next Steps

1. ✅ **Login to pgAdmin** (Simple Browser already opened)
2. ✅ **Add PostgreSQL server connection**
3. ✅ **Explore the employee table with 21 records**
4. ✅ **Try the sample queries above**
5. 🎯 **Start building your React CRUD application!**

---
*Your PostgreSQL database is ready with a complete employee management schema and sample data!*