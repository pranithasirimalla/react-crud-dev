package com.employee.management.service;

import com.employee.management.dto.EmployeeDto;
import com.employee.management.dto.EmployeeRequest;
import com.employee.management.dto.EmployeeSearchRequest;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Service interface for Employee operations
 */
public interface EmployeeService {

    /**
     * Get all active employees
     */
    List<EmployeeDto> getAllEmployees();

    /**
     * Get employees with pagination
     */
    Page<EmployeeDto> getAllEmployees(int page, int size, String sortBy, String sortDirection);

    /**
     * Get employee by ID
     */
    EmployeeDto getEmployeeById(Integer id);

    /**
     * Create new employee
     */
    EmployeeDto createEmployee(EmployeeRequest request);

    /**
     * Update existing employee
     */
    EmployeeDto updateEmployee(Integer id, EmployeeRequest request);

    /**
     * Soft delete employee
     */
    void deleteEmployee(Integer id);

    /**
     * Search employees with multiple criteria
     */
    Page<EmployeeDto> searchEmployees(EmployeeSearchRequest searchRequest);

    /**
     * Get employees by department
     */
    List<EmployeeDto> getEmployeesByDepartment(String department);

    /**
     * Get employees by position
     */
    List<EmployeeDto> getEmployeesByPosition(String position);

    /**
     * Get employees by manager
     */
    List<EmployeeDto> getEmployeesByManager(Integer managerId);

    /**
     * Get all departments
     */
    List<String> getAllDepartments();

    /**
     * Get all positions
     */
    List<String> getAllPositions();

    /**
     * Check if employee exists by email
     */
    boolean existsByEmail(String email);

    /**
     * Check if employee exists by email (excluding specific ID)
     */
    boolean existsByEmailAndIdNot(String email, Integer id);
}