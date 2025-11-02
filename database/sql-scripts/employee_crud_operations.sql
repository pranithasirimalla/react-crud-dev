-- =====================================================
-- CRUD Operations Script for Employee Table
-- =====================================================
-- This script demonstrates all CRUD operations on the employee table
-- Created for: React CRUD Development Learning
-- Database: employee_db
-- Table: employees

-- =====================================================
-- CREATE Operations (Insert)
-- =====================================================

-- 1. Insert a new employee (basic)
INSERT INTO employees (
    first_name, 
    last_name, 
    email, 
    phone, 
    department, 
    position, 
    salary, 
    hire_date
) VALUES (
    'Alice', 
    'Cooper', 
    'alice.cooper@company.com', 
    '+1-555-0022', 
    'Engineering', 
    'Junior Developer', 
    65000.00, 
    CURRENT_DATE
);

-- 2. Insert a new employee with manager
INSERT INTO employees (
    first_name, 
    last_name, 
    email, 
    phone, 
    department, 
    position, 
    salary, 
    hire_date,
    manager_id
) VALUES (
    'Bob', 
    'Wilson', 
    'bob.wilson@company.com', 
    '+1-555-0023', 
    'Sales', 
    'Junior Sales Rep', 
    48000.00, 
    CURRENT_DATE,
    (SELECT id FROM employees WHERE email = 'michael.brown@company.com')
);

-- 3. Bulk insert multiple employees
INSERT INTO employees (first_name, last_name, email, phone, department, position, salary, hire_date, manager_id) VALUES
('Carol', 'Davis', 'carol.davis@company.com', '+1-555-0024', 'Marketing', 'Graphic Designer', 54000.00, CURRENT_DATE, (SELECT id FROM employees WHERE email = 'emily.davis@company.com')),
('David', 'Miller', 'david.miller@company.com', '+1-555-0025', 'Engineering', 'QA Engineer', 72000.00, CURRENT_DATE, (SELECT id FROM employees WHERE email = 'sarah.johnson@company.com')),
('Eve', 'Taylor', 'eve.taylor@company.com', '+1-555-0026', 'HR', 'Benefits Coordinator', 55000.00, CURRENT_DATE, (SELECT id FROM employees WHERE email = 'david.wilson@company.com'));

-- =====================================================
-- READ Operations (Select)
-- =====================================================

-- 1. Select all active employees
SELECT * FROM employees WHERE is_active = true ORDER BY id;

-- 2. Select employees by department
SELECT 
    id,
    first_name,
    last_name,
    email,
    position,
    salary
FROM employees 
WHERE department = 'Engineering' 
  AND is_active = true
ORDER BY salary DESC;

-- 3. Select employee with manager information
SELECT 
    e.id,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.email,
    e.department,
    e.position,
    e.salary,
    e.hire_date,
    COALESCE(m.first_name || ' ' || m.last_name, 'No Manager') AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
WHERE e.is_active = true
ORDER BY e.department, e.salary DESC;

-- 4. Count employees by department
SELECT 
    department,
    COUNT(*) as total_employees,
    COUNT(CASE WHEN is_active = true THEN 1 END) as active_employees,
    AVG(salary) as average_salary,
    MAX(salary) as max_salary,
    MIN(salary) as min_salary
FROM employees 
GROUP BY department 
ORDER BY total_employees DESC;

-- 5. Find employees hired in the last 30 days
SELECT 
    first_name,
    last_name,
    email,
    department,
    position,
    hire_date,
    CURRENT_DATE - hire_date as days_employed
FROM employees 
WHERE hire_date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY hire_date DESC;

-- 6. Find all managers and their direct reports
SELECT 
    m.first_name || ' ' || m.last_name as manager,
    m.department as manager_department,
    COUNT(e.id) as direct_reports,
    STRING_AGG(e.first_name || ' ' || e.last_name, ', ') as report_names
FROM employees m
INNER JOIN employees e ON m.id = e.manager_id
WHERE m.is_active = true AND e.is_active = true
GROUP BY m.id, m.first_name, m.last_name, m.department
ORDER BY direct_reports DESC;

-- 7. Search employees by name or email (useful for search functionality)
SELECT 
    id,
    first_name,
    last_name,
    email,
    department,
    position
FROM employees 
WHERE (
    LOWER(first_name || ' ' || last_name) LIKE LOWER('%john%') 
    OR LOWER(email) LIKE LOWER('%john%')
) AND is_active = true
ORDER BY last_name, first_name;

-- 8. Salary range analysis
SELECT 
    department,
    CASE 
        WHEN salary < 50000 THEN 'Entry Level'
        WHEN salary BETWEEN 50000 AND 80000 THEN 'Mid Level'
        WHEN salary BETWEEN 80000 AND 120000 THEN 'Senior Level'
        ELSE 'Executive Level'
    END as salary_bracket,
    COUNT(*) as employee_count
FROM employees 
WHERE is_active = true
GROUP BY department, salary_bracket
ORDER BY department, MIN(salary);

-- =====================================================
-- UPDATE Operations
-- =====================================================

-- 1. Update employee salary (single employee)
UPDATE employees 
SET 
    salary = 82000.00,
    updated_at = CURRENT_TIMESTAMP
WHERE email = 'robert.martinez@company.com';

-- 2. Update employee department and position (promotion)
UPDATE employees 
SET 
    department = 'Engineering',
    position = 'Senior Software Engineer',
    salary = 98000.00,
    manager_id = (SELECT id FROM employees WHERE email = 'sarah.johnson@company.com'),
    updated_at = CURRENT_TIMESTAMP
WHERE email = 'lisa.anderson@company.com';

-- 3. Update employee contact information
UPDATE employees 
SET 
    phone = '+1-555-9999',
    email = 'jennifer.garcia.new@company.com',
    updated_at = CURRENT_TIMESTAMP
WHERE id = (SELECT id FROM employees WHERE email = 'jennifer.garcia@company.com');

-- 4. Bulk salary increase for a department (5% raise)
UPDATE employees 
SET 
    salary = salary * 1.05,
    updated_at = CURRENT_TIMESTAMP
WHERE department = 'Sales' AND is_active = true;

-- 5. Update manager for multiple employees
UPDATE employees 
SET 
    manager_id = (SELECT id FROM employees WHERE email = 'sarah.johnson@company.com'),
    updated_at = CURRENT_TIMESTAMP
WHERE department = 'Engineering' 
  AND manager_id IS NULL 
  AND email != 'sarah.johnson@company.com';

-- =====================================================
-- DELETE Operations (Soft Delete - Recommended)
-- =====================================================

-- 1. Soft delete employee (mark as inactive)
UPDATE employees 
SET 
    is_active = false,
    updated_at = CURRENT_TIMESTAMP
WHERE email = 'mark.johnson@company.com';

-- 2. Soft delete multiple employees
UPDATE employees 
SET 
    is_active = false,
    updated_at = CURRENT_TIMESTAMP
WHERE id IN (
    SELECT id FROM employees 
    WHERE hire_date < '2021-01-01' 
      AND position LIKE '%Assistant%'
);

-- =====================================================
-- DELETE Operations (Hard Delete - Use with Caution)
-- =====================================================

-- 3. Hard delete inactive employees (DANGEROUS - removes data permanently)
-- DELETE FROM employees WHERE is_active = false;

-- 4. Hard delete specific employee by ID (DANGEROUS)
-- DELETE FROM employees WHERE id = 999;

-- =====================================================
-- ADVANCED CRUD Operations
-- =====================================================

-- 1. Upsert operation (Insert or Update if exists)
INSERT INTO employees (
    first_name, last_name, email, phone, department, position, salary, hire_date
) VALUES (
    'Frank', 'Miller', 'frank.miller@company.com', '+1-555-0027', 
    'Finance', 'Financial Analyst', 67000.00, CURRENT_DATE
) 
ON CONFLICT (email) 
DO UPDATE SET 
    phone = EXCLUDED.phone,
    salary = EXCLUDED.salary,
    updated_at = CURRENT_TIMESTAMP;

-- 2. Conditional update with CASE
UPDATE employees 
SET salary = CASE 
    WHEN department = 'Engineering' THEN salary * 1.08
    WHEN department = 'Sales' THEN salary * 1.06
    WHEN department = 'Marketing' THEN salary * 1.05
    ELSE salary * 1.03
END,
updated_at = CURRENT_TIMESTAMP
WHERE is_active = true;

-- 3. Transfer employees to new manager when manager leaves
UPDATE employees 
SET manager_id = (
    SELECT manager_id 
    FROM employees 
    WHERE id = (SELECT manager_id FROM employees WHERE email = 'emily.davis@company.com')
),
updated_at = CURRENT_TIMESTAMP
WHERE manager_id = (SELECT id FROM employees WHERE email = 'emily.davis@company.com')
  AND email != 'emily.davis@company.com';

-- =====================================================
-- Utility Queries for Application Development
-- =====================================================

-- 1. Get employee details by ID (for view/edit forms)
SELECT 
    id,
    first_name,
    last_name,
    email,
    phone,
    department,
    position,
    salary,
    hire_date,
    manager_id,
    is_active,
    created_at,
    updated_at
FROM employees 
WHERE id = :employee_id;

-- 2. Get all departments for dropdown
SELECT DISTINCT department 
FROM employees 
WHERE is_active = true 
ORDER BY department;

-- 3. Get all managers for dropdown (employees with direct reports)
SELECT DISTINCT 
    m.id,
    m.first_name || ' ' || m.last_name as manager_name,
    m.department
FROM employees m
INNER JOIN employees e ON m.id = e.manager_id
WHERE m.is_active = true
ORDER BY manager_name;

-- 4. Pagination query (for large datasets)
SELECT 
    id,
    first_name,
    last_name,
    email,
    department,
    position,
    salary
FROM employees 
WHERE is_active = true
ORDER BY id
LIMIT 10 OFFSET 0;  -- Change OFFSET for different pages

-- 5. Full-text search across multiple columns
SELECT 
    id,
    first_name,
    last_name,
    email,
    department,
    position,
    salary,
    ts_rank(
        to_tsvector('english', first_name || ' ' || last_name || ' ' || email || ' ' || department || ' ' || position),
        to_tsquery('english', 'engineer')
    ) as relevance_score
FROM employees 
WHERE to_tsvector('english', first_name || ' ' || last_name || ' ' || email || ' ' || department || ' ' || position) 
      @@ to_tsquery('english', 'engineer')
  AND is_active = true
ORDER BY relevance_score DESC;

-- =====================================================
-- Data Validation Queries
-- =====================================================

-- 1. Check for duplicate emails
SELECT email, COUNT(*) as count 
FROM employees 
GROUP BY email 
HAVING COUNT(*) > 1;

-- 2. Find employees without managers (except CEO)
SELECT id, first_name, last_name, position 
FROM employees 
WHERE manager_id IS NULL 
  AND position != 'Chief Executive Officer' 
  AND is_active = true;

-- 3. Validate salary ranges by position
SELECT 
    position,
    MIN(salary) as min_salary,
    MAX(salary) as max_salary,
    AVG(salary) as avg_salary,
    COUNT(*) as employee_count
FROM employees 
WHERE is_active = true
GROUP BY position 
ORDER BY avg_salary DESC;

-- =====================================================
-- Performance Monitoring Queries
-- =====================================================

-- 1. Recently modified employees
SELECT 
    first_name,
    last_name,
    email,
    updated_at,
    updated_at - created_at as time_since_creation
FROM employees 
WHERE updated_at > CURRENT_TIMESTAMP - INTERVAL '7 days'
ORDER BY updated_at DESC;

-- 2. Employee table statistics
SELECT 
    COUNT(*) as total_employees,
    COUNT(CASE WHEN is_active = true THEN 1 END) as active_employees,
    COUNT(CASE WHEN is_active = false THEN 1 END) as inactive_employees,
    COUNT(DISTINCT department) as total_departments,
    AVG(salary) as average_salary
FROM employees;

-- =====================================================
-- End of CRUD Operations Script
-- =====================================================