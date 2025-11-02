-- =====================================================
-- React Application CRUD Operations
-- =====================================================
-- Simplified SQL operations for React CRUD application
-- Copy these queries into your React app or test them in pgAdmin

-- =====================================================
-- 1. CREATE (Add New Employee)
-- =====================================================

-- Add new employee (typical form submission)
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
    'John',           -- first_name
    'Doe',            -- last_name  
    'john.doe@company.com',  -- email
    '+1-555-0100',    -- phone
    'Engineering',    -- department
    'Software Engineer', -- position
    75000.00,         -- salary
    CURRENT_DATE,     -- hire_date
    2                 -- manager_id (Sarah Johnson's ID)
) RETURNING id, first_name, last_name, email;

-- =====================================================
-- 2. READ (Get Employees)
-- =====================================================

-- Get all active employees (for employee list page)
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
    is_active
FROM employees 
WHERE is_active = true 
ORDER BY last_name, first_name;

-- Get single employee by ID (for edit form)
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
    is_active
FROM employees 
WHERE id = 1;  -- Replace with actual ID

-- Get employees with manager names (for display)
SELECT 
    e.id,
    e.first_name,
    e.last_name,
    e.email,
    e.department,
    e.position,
    e.salary,
    COALESCE(m.first_name || ' ' || m.last_name, 'No Manager') as manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
WHERE e.is_active = true
ORDER BY e.department, e.last_name;

-- Search employees (for search functionality)
SELECT 
    id,
    first_name,
    last_name,
    email,
    department,
    position
FROM employees 
WHERE is_active = true 
  AND (
    LOWER(first_name || ' ' || last_name) LIKE LOWER('%search_term%') 
    OR LOWER(email) LIKE LOWER('%search_term%')
    OR LOWER(department) LIKE LOWER('%search_term%')
    OR LOWER(position) LIKE LOWER('%search_term%')
  )
ORDER BY last_name, first_name;

-- Get employees by department (for filtering)
SELECT 
    id,
    first_name,
    last_name,
    email,
    position,
    salary
FROM employees 
WHERE department = 'Engineering'  -- Replace with selected department
  AND is_active = true
ORDER BY salary DESC;

-- =====================================================
-- 3. UPDATE (Edit Employee)
-- =====================================================

-- Update employee information
UPDATE employees 
SET 
    first_name = 'UpdatedFirstName',
    last_name = 'UpdatedLastName',
    email = 'updated.email@company.com',
    phone = '+1-555-9999',
    department = 'Marketing',
    position = 'Senior Marketing Manager',
    salary = 85000.00,
    manager_id = 4,
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1  -- Replace with actual employee ID
RETURNING id, first_name, last_name, email, updated_at;

-- Update only specific fields (partial update)
UPDATE employees 
SET 
    salary = 80000.00,
    position = 'Senior Developer',
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1
RETURNING id, salary, position, updated_at;

-- =====================================================
-- 4. DELETE (Soft Delete - Recommended)
-- =====================================================

-- Soft delete (mark as inactive) - RECOMMENDED
UPDATE employees 
SET 
    is_active = false,
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1
RETURNING id, first_name, last_name, is_active;

-- Reactivate employee (undo soft delete)
UPDATE employees 
SET 
    is_active = true,
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1
RETURNING id, first_name, last_name, is_active;

-- =====================================================
-- 5. UTILITY QUERIES (For Dropdowns & Lists)
-- =====================================================

-- Get all departments for dropdown
SELECT DISTINCT department 
FROM employees 
WHERE is_active = true 
ORDER BY department;

-- Get all managers for dropdown
SELECT 
    id,
    first_name || ' ' || last_name as name,
    department
FROM employees 
WHERE id IN (
    SELECT DISTINCT manager_id 
    FROM employees 
    WHERE manager_id IS NOT NULL
) AND is_active = true
ORDER BY name;

-- Get employee count by department (for dashboard)
SELECT 
    department,
    COUNT(*) as employee_count
FROM employees 
WHERE is_active = true
GROUP BY department 
ORDER BY employee_count DESC;

-- =====================================================
-- 6. VALIDATION QUERIES
-- =====================================================

-- Check if email already exists (before insert/update)
SELECT COUNT(*) as email_exists 
FROM employees 
WHERE email = 'new.email@company.com' 
  AND id != 1;  -- Exclude current employee ID when updating

-- Validate employee exists
SELECT COUNT(*) as employee_exists 
FROM employees 
WHERE id = 1 AND is_active = true;

-- =====================================================
-- 7. PAGINATION QUERIES (For Large Datasets)
-- =====================================================

-- Get employees with pagination
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
LIMIT 10 OFFSET 0;  -- Page 1: OFFSET 0, Page 2: OFFSET 10, etc.

-- Get total count for pagination
SELECT COUNT(*) as total_employees 
FROM employees 
WHERE is_active = true;

-- =====================================================
-- 8. SAMPLE API ENDPOINT QUERIES
-- =====================================================

-- GET /api/employees (List all employees)
SELECT 
    id,
    first_name,
    last_name,
    email,
    department,
    position,
    salary,
    hire_date
FROM employees 
WHERE is_active = true 
ORDER BY id;

-- GET /api/employees/:id (Get specific employee)
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
WHERE id = $1 AND is_active = true;

-- POST /api/employees (Create new employee)
-- Use the INSERT query from section 1

-- PUT /api/employees/:id (Update employee)
-- Use the UPDATE query from section 3

-- DELETE /api/employees/:id (Delete employee)
-- Use the soft delete UPDATE query from section 4