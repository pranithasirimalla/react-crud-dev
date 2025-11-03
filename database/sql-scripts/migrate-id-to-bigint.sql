-- Migration script to change employee ID from SERIAL (INTEGER) to BIGSERIAL (BIGINT)
-- This ensures compatibility with JPA Long type

-- Step 1: Create a temporary column with BIGINT type
ALTER TABLE employees ADD COLUMN temp_id BIGSERIAL;

-- Step 2: Copy existing IDs to the temporary column
UPDATE employees SET temp_id = id;

-- Step 3: Update any foreign key references (manager_id) to use the new temp_id values
-- Since manager_id references the same table, we need to handle this carefully

-- Step 4: Drop the old id column (this will also drop the primary key constraint)
ALTER TABLE employees DROP CONSTRAINT employees_pkey CASCADE;
ALTER TABLE employees DROP COLUMN id;

-- Step 5: Rename temp_id to id
ALTER TABLE employees RENAME COLUMN temp_id TO id;

-- Step 6: Recreate the primary key constraint
ALTER TABLE employees ADD PRIMARY KEY (id);

-- Step 7: Recreate the foreign key constraint for manager_id
ALTER TABLE employees ADD CONSTRAINT fk_employees_manager 
    FOREIGN KEY (manager_id) REFERENCES employees(id);

-- Step 8: Update the sequence to start from the correct value
SELECT setval('employees_id_seq', COALESCE((SELECT MAX(id) FROM employees), 1));

-- Verify the change
\d employees;
