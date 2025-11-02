-- Employee Seed Data
-- This file contains sample employee records for initial database setup

-- Insert sample employees
INSERT INTO employees (
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
) VALUES 
-- CEO (no manager)
('John', 'Smith', 'john.smith@company.com', '+1-555-0001', 'Executive', 'Chief Executive Officer', 250000.00, '2020-01-15', NULL, true),

-- Department Managers
('Sarah', 'Johnson', 'sarah.johnson@company.com', '+1-555-0002', 'Engineering', 'Engineering Manager', 120000.00, '2020-03-01', 1, true),
('Michael', 'Brown', 'michael.brown@company.com', '+1-555-0003', 'Sales', 'Sales Manager', 110000.00, '2020-02-15', 1, true),
('Emily', 'Davis', 'emily.davis@company.com', '+1-555-0004', 'Marketing', 'Marketing Manager', 105000.00, '2020-04-01', 1, true),
('David', 'Wilson', 'david.wilson@company.com', '+1-555-0005', 'HR', 'HR Manager', 95000.00, '2020-05-01', 1, true),

-- Engineering Team
('Jennifer', 'Garcia', 'jennifer.garcia@company.com', '+1-555-0006', 'Engineering', 'Senior Software Engineer', 95000.00, '2021-01-15', 2, true),
('Robert', 'Martinez', 'robert.martinez@company.com', '+1-555-0007', 'Engineering', 'Software Engineer', 80000.00, '2021-06-01', 2, true),
('Lisa', 'Anderson', 'lisa.anderson@company.com', '+1-555-0008', 'Engineering', 'Frontend Developer', 75000.00, '2022-01-10', 2, true),
('James', 'Taylor', 'james.taylor@company.com', '+1-555-0009', 'Engineering', 'Backend Developer', 78000.00, '2022-03-15', 2, true),
('Maria', 'Thomas', 'maria.thomas@company.com', '+1-555-0010', 'Engineering', 'DevOps Engineer', 85000.00, '2021-09-01', 2, true),

-- Sales Team
('Christopher', 'Jackson', 'christopher.jackson@company.com', '+1-555-0011', 'Sales', 'Senior Sales Representative', 70000.00, '2021-02-01', 3, true),
('Amanda', 'White', 'amanda.white@company.com', '+1-555-0012', 'Sales', 'Sales Representative', 55000.00, '2022-01-15', 3, true),
('Daniel', 'Harris', 'daniel.harris@company.com', '+1-555-0013', 'Sales', 'Sales Representative', 57000.00, '2022-04-01', 3, true),
('Michelle', 'Martin', 'michelle.martin@company.com', '+1-555-0014', 'Sales', 'Account Executive', 65000.00, '2021-08-15', 3, true),

-- Marketing Team
('Kevin', 'Thompson', 'kevin.thompson@company.com', '+1-555-0015', 'Marketing', 'Digital Marketing Specialist', 60000.00, '2021-11-01', 4, true),
('Nicole', 'Garcia', 'nicole.garcia@company.com', '+1-555-0016', 'Marketing', 'Content Creator', 55000.00, '2022-02-15', 4, true),
('Brian', 'Rodriguez', 'brian.rodriguez@company.com', '+1-555-0017', 'Marketing', 'Social Media Manager', 58000.00, '2022-05-01', 4, true),

-- HR Team
('Jessica', 'Lewis', 'jessica.lewis@company.com', '+1-555-0018', 'HR', 'HR Specialist', 50000.00, '2021-07-01', 5, true),
('Ryan', 'Lee', 'ryan.lee@company.com', '+1-555-0019', 'HR', 'Recruiter', 52000.00, '2022-03-01', 5, true),

-- Some inactive employees (former employees)
('Mark', 'Johnson', 'mark.johnson@company.com', '+1-555-0020', 'Sales', 'Sales Representative', 54000.00, '2020-06-01', 3, false),
('Rachel', 'Brown', 'rachel.brown@company.com', '+1-555-0021', 'Marketing', 'Marketing Assistant', 45000.00, '2021-01-01', 4, false);

-- Display inserted data count
DO $$
DECLARE 
    employee_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO employee_count FROM employees;
    RAISE NOTICE 'Successfully inserted % employee records', employee_count;
END $$;