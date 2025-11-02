-- =====================================================
-- Quick Test Script - Run in pgAdmin Query Tool
-- =====================================================
-- Test these queries one by one in pgAdmin to see your data

-- 1. Show all employees with their managers
SELECT 
    e.id,
    e.first_name || ' ' || e.last_name as employee,
    e.email,
    e.department,
    e.position,
    e.salary,
    COALESCE(m.first_name || ' ' || m.last_name, 'CEO (No Manager)') as manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
WHERE e.is_active = true
ORDER BY e.department, e.salary DESC;

-- 2. Count employees by department
SELECT 
    department,
    COUNT(*) as total_employees,
    AVG(salary)::NUMERIC(10,2) as avg_salary,
    MAX(salary) as highest_salary
FROM employees 
WHERE is_active = true
GROUP BY department 
ORDER BY total_employees DESC;

-- 3. Find highest paid employee in each department
SELECT DISTINCT ON (department)
    department,
    first_name || ' ' || last_name as employee,
    position,
    salary
FROM employees 
WHERE is_active = true
ORDER BY department, salary DESC;

-- 4. Show organizational hierarchy (CEO -> Managers -> Staff)
WITH RECURSIVE employee_hierarchy AS (
    -- CEO level (no manager)
    SELECT 
        id,
        first_name || ' ' || last_name as name,
        position,
        manager_id,
        0 as level,
        first_name || ' ' || last_name as path
    FROM employees 
    WHERE manager_id IS NULL AND is_active = true
    
    UNION ALL
    
    -- All other levels
    SELECT 
        e.id,
        e.first_name || ' ' || e.last_name as name,
        e.position,
        e.manager_id,
        eh.level + 1,
        eh.path || ' -> ' || e.first_name || ' ' || e.last_name
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.id
    WHERE e.is_active = true
)
SELECT 
    REPEAT('  ', level) || name as hierarchy,
    position,
    level
FROM employee_hierarchy 
ORDER BY path;

-- 5. Recent hires (last 30 days) - will be empty with seed data
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
  AND is_active = true
ORDER BY hire_date DESC;

-- 6. Salary analysis
SELECT 
    'Total Payroll' as metric,
    SUM(salary)::NUMERIC(12,2) as amount
FROM employees WHERE is_active = true
UNION ALL
SELECT 
    'Average Salary' as metric,
    AVG(salary)::NUMERIC(10,2) as amount
FROM employees WHERE is_active = true
UNION ALL
SELECT 
    'Highest Salary' as metric,
    MAX(salary)::NUMERIC(10,2) as amount
FROM employees WHERE is_active = true
UNION ALL
SELECT 
    'Lowest Salary' as metric,
    MIN(salary)::NUMERIC(10,2) as amount
FROM employees WHERE is_active = true;

-- 7. Search example (find all Johns)
SELECT 
    id,
    first_name,
    last_name,
    email,
    department,
    position
FROM employees 
WHERE (first_name ILIKE '%john%' OR last_name ILIKE '%john%')
  AND is_active = true;

-- 8. Employees without direct reports (individual contributors)
SELECT 
    e.first_name || ' ' || e.last_name as employee,
    e.department,
    e.position,
    e.salary
FROM employees e
LEFT JOIN employees reports ON e.id = reports.manager_id
WHERE reports.manager_id IS NULL 
  AND e.is_active = true
ORDER BY e.department, e.salary DESC;

-- 9. Managers and their team sizes
SELECT 
    m.first_name || ' ' || m.last_name as manager,
    m.department,
    COUNT(e.id) as team_size,
    STRING_AGG(e.first_name || ' ' || e.last_name, ', ' ORDER BY e.last_name) as team_members
FROM employees m
INNER JOIN employees e ON m.id = e.manager_id
WHERE m.is_active = true AND e.is_active = true
GROUP BY m.id, m.first_name, m.last_name, m.department
ORDER BY team_size DESC;

-- 10. Department budget (total salaries)
SELECT 
    department,
    COUNT(*) as employees,
    SUM(salary)::NUMERIC(12,2) as total_budget,
    AVG(salary)::NUMERIC(10,2) as avg_salary
FROM employees 
WHERE is_active = true
GROUP BY department 
ORDER BY total_budget DESC;