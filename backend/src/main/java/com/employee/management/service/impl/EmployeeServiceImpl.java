package com.employee.management.service.impl;

import com.employee.management.dto.EmployeeDto;
import com.employee.management.dto.EmployeeRequest;
import com.employee.management.dto.EmployeeSearchRequest;
import com.employee.management.entity.Employee;
import com.employee.management.exception.ResourceNotFoundException;
import com.employee.management.exception.DuplicateResourceException;
import com.employee.management.repository.EmployeeRepository;
import com.employee.management.service.EmployeeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementation of EmployeeService
 * Handles all business logic for employee operations
 */
@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class EmployeeServiceImpl implements EmployeeService {

    private final EmployeeRepository employeeRepository;
    private final ModelMapper modelMapper;

    @Override
    @Transactional(readOnly = true)
    public List<EmployeeDto> getAllEmployees() {
        log.debug("Fetching all active employees");
        List<Employee> employees = employeeRepository.findByIsActiveTrue();
        return employees.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public Page<EmployeeDto> getAllEmployees(int page, int size, String sortBy, String sortDirection) {
        log.debug("Fetching employees with pagination: page={}, size={}, sortBy={}, sortDirection={}", 
                  page, size, sortBy, sortDirection);
        
        Sort sort = sortDirection.equalsIgnoreCase("DESC") 
                   ? Sort.by(sortBy).descending() 
                   : Sort.by(sortBy).ascending();
        
        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Employee> employees = employeeRepository.findByIsActiveTrue(pageable);
        
        return employees.map(this::convertToDto);
    }

    @Override
    @Transactional(readOnly = true)
    public EmployeeDto getEmployeeById(Integer id) {
        log.debug("Fetching employee with id: {}", id);
        Employee employee = employeeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with id: " + id));
        
        if (!employee.getIsActive()) {
            throw new ResourceNotFoundException("Employee with id " + id + " is inactive");
        }
        
        return convertToDto(employee);
    }

    @Override
    public EmployeeDto createEmployee(EmployeeRequest request) {
        log.debug("Creating new employee with email: {}", request.getEmail());
        
        // Check if email already exists
        if (employeeRepository.existsByEmailIgnoreCase(request.getEmail())) {
            throw new DuplicateResourceException("Employee with email " + request.getEmail() + " already exists");
        }
        
        // Validate manager exists if managerId is provided
        if (request.getManagerId() != null) {
            validateManagerExists(request.getManagerId());
        }
        
        Employee employee = convertToEntity(request);
        
        // Set hire date if not provided
        if (employee.getHireDate() == null) {
            employee.setHireDate(LocalDate.now());
        }
        
        Employee savedEmployee = employeeRepository.save(employee);
        log.info("Employee created successfully with id: {}", savedEmployee.getId());
        
        return convertToDto(savedEmployee);
    }

    @Override
    public EmployeeDto updateEmployee(Integer id, EmployeeRequest request) {
        log.debug("Updating employee with id: {}", id);
        
        Employee existingEmployee = employeeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with id: " + id));
        
        if (!existingEmployee.getIsActive()) {
            throw new ResourceNotFoundException("Cannot update inactive employee with id: " + id);
        }
        
        // Check if email is being changed and if new email already exists
        if (!existingEmployee.getEmail().equalsIgnoreCase(request.getEmail())) {
            if (employeeRepository.existsByEmailIgnoreCaseAndIdNot(request.getEmail(), id)) {
                throw new DuplicateResourceException("Employee with email " + request.getEmail() + " already exists");
            }
        }
        
        // Validate manager exists if managerId is provided
        if (request.getManagerId() != null) {
            validateManagerExists(request.getManagerId());
        }
        
        // Update employee fields
        updateEmployeeFields(existingEmployee, request);
        
        Employee updatedEmployee = employeeRepository.save(existingEmployee);
        log.info("Employee updated successfully with id: {}", updatedEmployee.getId());
        
        return convertToDto(updatedEmployee);
    }

    @Override
    public void deleteEmployee(Integer id) {
        log.debug("Soft deleting employee with id: {}", id);
        
        Employee employee = employeeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with id: " + id));
        
        if (!employee.getIsActive()) {
            throw new ResourceNotFoundException("Employee with id " + id + " is already inactive");
        }
        
        employee.setIsActive(false);
        employeeRepository.save(employee);
        
        log.info("Employee soft deleted successfully with id: {}", id);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<EmployeeDto> searchEmployees(EmployeeSearchRequest searchRequest) {
        log.debug("Searching employees with criteria: {}", searchRequest);
        
        Sort sort = searchRequest.getSortDirection().equalsIgnoreCase("DESC") 
                   ? Sort.by(searchRequest.getSortBy()).descending() 
                   : Sort.by(searchRequest.getSortBy()).ascending();
        
        Pageable pageable = PageRequest.of(searchRequest.getPage(), searchRequest.getSize(), sort);
        
        Page<Employee> employees = employeeRepository.searchEmployees(
                searchRequest.getSearchTerm(),
                searchRequest.getDepartment(),
                searchRequest.getPosition(),
                pageable
        );
        
        return employees.map(this::convertToDto);
    }

    @Override
    @Transactional(readOnly = true)
    public List<EmployeeDto> getEmployeesByDepartment(String department) {
        log.debug("Fetching employees by department: {}", department);
        List<Employee> employees = employeeRepository.findByDepartmentIgnoreCaseAndIsActiveTrue(department);
        return employees.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<EmployeeDto> getEmployeesByPosition(String position) {
        log.debug("Fetching employees by position: {}", position);
        List<Employee> employees = employeeRepository.findByPositionIgnoreCaseAndIsActiveTrue(position);
        return employees.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<EmployeeDto> getEmployeesByManager(Integer managerId) {
        log.debug("Fetching employees by manager id: {}", managerId);
        
        // Validate manager exists
        validateManagerExists(managerId);
        
        List<Employee> employees = employeeRepository.findByManagerIdAndIsActiveTrue(managerId);
        return employees.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<String> getAllDepartments() {
        log.debug("Fetching all departments");
        return employeeRepository.findAllDistinctDepartments();
    }

    @Override
    @Transactional(readOnly = true)
    public List<String> getAllPositions() {
        log.debug("Fetching all positions");
        return employeeRepository.findAllDistinctPositions();
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByEmail(String email) {
        return employeeRepository.existsByEmailIgnoreCase(email);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByEmailAndIdNot(String email, Integer id) {
        return employeeRepository.existsByEmailIgnoreCaseAndIdNot(email, id);
    }

    /**
     * Convert Employee entity to EmployeeDto
     */
    private EmployeeDto convertToDto(Employee employee) {
        EmployeeDto dto = new EmployeeDto();
        
        // Map basic fields
        dto.setId(employee.getId());
        dto.setFirstName(employee.getFirstName());
        dto.setLastName(employee.getLastName());
        dto.setFullName(employee.getFullName());
        dto.setEmail(employee.getEmail());
        dto.setPhone(employee.getPhone());
        dto.setDepartment(employee.getDepartment());
        dto.setPosition(employee.getPosition());
        dto.setSalary(employee.getSalary());
        dto.setHireDate(employee.getHireDate());
        dto.setIsActive(employee.getIsActive());
        dto.setCreatedAt(employee.getCreatedAt());
        dto.setUpdatedAt(employee.getUpdatedAt());
        
        // Map manager information
        dto.setManagerId(employee.getManagerId());
        if (employee.getManager() != null) {
            dto.setManagerName(employee.getManager().getFullName());
        }
        
        return dto;
    }

    /**
     * Convert EmployeeRequest to Employee entity
     */
    private Employee convertToEntity(EmployeeRequest request) {
        return modelMapper.map(request, Employee.class);
    }

    /**
     * Update employee fields from request
     */
    private void updateEmployeeFields(Employee employee, EmployeeRequest request) {
        employee.setFirstName(request.getFirstName());
        employee.setLastName(request.getLastName());
        employee.setEmail(request.getEmail());
        employee.setPhone(request.getPhone());
        employee.setDepartment(request.getDepartment());
        employee.setPosition(request.getPosition());
        employee.setSalary(request.getSalary());
        employee.setManagerId(request.getManagerId());
        
        if (request.getHireDate() != null) {
            employee.setHireDate(request.getHireDate());
        }
        
        if (request.getIsActive() != null) {
            employee.setIsActive(request.getIsActive());
        }
    }

    /**
     * Validate that manager exists and is active
     */
    private void validateManagerExists(Integer managerId) {
        Employee manager = employeeRepository.findById(managerId)
                .orElseThrow(() -> new ResourceNotFoundException("Manager not found with id: " + managerId));
        
        if (!manager.getIsActive()) {
            throw new ResourceNotFoundException("Manager with id " + managerId + " is inactive");
        }
    }
}