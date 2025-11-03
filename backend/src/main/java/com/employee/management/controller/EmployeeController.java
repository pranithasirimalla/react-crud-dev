package com.employee.management.controller;

import com.employee.management.dto.ApiResponse;
import com.employee.management.dto.EmployeeDto;
import com.employee.management.dto.EmployeeRequest;
import com.employee.management.dto.EmployeeSearchRequest;
import com.employee.management.service.EmployeeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST Controller for Employee CRUD operations
 */
@RestController
@RequestMapping("/v1/employees")
@RequiredArgsConstructor
@Slf4j
@CrossOrigin(origins = "*") // For frontend integration
@Tag(name = "Employee Management", description = "Comprehensive Employee Management API with CRUD operations, search, pagination, and hierarchical relationships")
public class EmployeeController {

    private final EmployeeService employeeService;

    @Operation(
        summary = "Get all employees",
        description = "Retrieves a list of all active employees in the system"
    )
    @ApiResponses(value = {
        @io.swagger.v3.oas.annotations.responses.ApiResponse(
            responseCode = "200", 
            description = "Successfully retrieved employees",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = ApiResponse.class)
            )
        ),
        @io.swagger.v3.oas.annotations.responses.ApiResponse(
            responseCode = "500", 
            description = "Internal server error"
        )
    })
    @GetMapping
    public ResponseEntity<ApiResponse<List<EmployeeDto>>> getAllEmployees() {
        log.info("Fetching all employees");
        
        List<EmployeeDto> employees = employeeService.getAllEmployees();
        
        ApiResponse<List<EmployeeDto>> response = ApiResponse.<List<EmployeeDto>>builder()
                .success(true)
                .message("Employees retrieved successfully")
                .data(employees)
                .build();
        
        return ResponseEntity.ok(response);
    }

    /**
     * Get employees with pagination
     * GET /api/v1/employees/paginated?page=0&size=10&sortBy=firstName&sortDirection=asc
     */
    @GetMapping("/paginated")
    public ResponseEntity<ApiResponse<Page<EmployeeDto>>> getAllEmployeesPaginated(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "firstName") String sortBy,
            @RequestParam(defaultValue = "asc") String sortDirection) {
        
        log.info("Fetching employees with pagination - page: {}, size: {}, sortBy: {}, sortDirection: {}", 
                page, size, sortBy, sortDirection);
        
        Page<EmployeeDto> employees = employeeService.getAllEmployees(page, size, sortBy, sortDirection);
        
        ApiResponse<Page<EmployeeDto>> response = ApiResponse.<Page<EmployeeDto>>builder()
                .success(true)
                .message("Employees retrieved successfully")
                .data(employees)
                .build();
        
        return ResponseEntity.ok(response);
    }

    @Operation(
        summary = "Get employee by ID",
        description = "Retrieves a specific employee by their unique identifier"
    )
    @ApiResponses(value = {
        @io.swagger.v3.oas.annotations.responses.ApiResponse(
            responseCode = "200", 
            description = "Employee found and retrieved successfully"
        ),
        @io.swagger.v3.oas.annotations.responses.ApiResponse(
            responseCode = "404", 
            description = "Employee not found or inactive"
        )
    })
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<EmployeeDto>> getEmployeeById(
        @Parameter(description = "Employee ID", example = "1", required = true)
        @PathVariable Integer id) {
        log.info("Fetching employee with id: {}", id);
        
        EmployeeDto employee = employeeService.getEmployeeById(id);
        
        ApiResponse<EmployeeDto> response = ApiResponse.<EmployeeDto>builder()
                .success(true)
                .message("Employee retrieved successfully")
                .data(employee)
                .build();
        
        return ResponseEntity.ok(response);
    }

    @Operation(
        summary = "Create new employee", 
        description = "Creates a new employee record with the provided information"
    )
    @ApiResponses(value = {
        @io.swagger.v3.oas.annotations.responses.ApiResponse(
            responseCode = "201", 
            description = "Employee created successfully"
        ),
        @io.swagger.v3.oas.annotations.responses.ApiResponse(
            responseCode = "400", 
            description = "Invalid input data or validation errors"
        ),
        @io.swagger.v3.oas.annotations.responses.ApiResponse(
            responseCode = "409", 
            description = "Employee with email already exists"
        )
    })
    @PostMapping
    public ResponseEntity<ApiResponse<EmployeeDto>> createEmployee(
        @Parameter(description = "Employee data", required = true)
        @Valid @RequestBody EmployeeRequest request) {
        log.info("Creating new employee with email: {}", request.getEmail());
        
        EmployeeDto employee = employeeService.createEmployee(request);
        
        ApiResponse<EmployeeDto> response = ApiResponse.<EmployeeDto>builder()
                .success(true)
                .message("Employee created successfully")
                .data(employee)
                .build();
        
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Update existing employee
     * PUT /api/v1/employees/{id}
     */
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<EmployeeDto>> updateEmployee(
            @PathVariable Integer id, 
            @Valid @RequestBody EmployeeRequest request) {
        
        log.info("Updating employee with id: {}", id);
        
        EmployeeDto employee = employeeService.updateEmployee(id, request);
        
        ApiResponse<EmployeeDto> response = ApiResponse.<EmployeeDto>builder()
                .success(true)
                .message("Employee updated successfully")
                .data(employee)
                .build();
        
        return ResponseEntity.ok(response);
    }

    /**
     * Delete employee (soft delete)
     * DELETE /api/v1/employees/{id}
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteEmployee(@PathVariable Integer id) {
        log.info("Deleting employee with id: {}", id);
        
        employeeService.deleteEmployee(id);
        
        ApiResponse<Void> response = ApiResponse.<Void>builder()
                .success(true)
                .message("Employee deleted successfully")
                .build();
        
        return ResponseEntity.ok(response);
    }

    /**
     * Search employees
     * POST /api/v1/employees/search
     */
    @PostMapping("/search")
    public ResponseEntity<ApiResponse<Page<EmployeeDto>>> searchEmployees(@RequestBody EmployeeSearchRequest searchRequest) {
        log.info("Searching employees with criteria: {}", searchRequest);
        
        Page<EmployeeDto> employees = employeeService.searchEmployees(searchRequest);
        
        ApiResponse<Page<EmployeeDto>> response = ApiResponse.<Page<EmployeeDto>>builder()
                .success(true)
                .message("Employees search completed successfully")
                .data(employees)
                .build();
        
        return ResponseEntity.ok(response);
    }

    /**
     * Get employees by department
     * GET /api/v1/employees/department/{department}
     */
    @GetMapping("/department/{department}")
    public ResponseEntity<ApiResponse<List<EmployeeDto>>> getEmployeesByDepartment(@PathVariable String department) {
        log.info("Fetching employees in department: {}", department);
        
        List<EmployeeDto> employees = employeeService.getEmployeesByDepartment(department);
        
        ApiResponse<List<EmployeeDto>> response = ApiResponse.<List<EmployeeDto>>builder()
                .success(true)
                .message("Employees retrieved successfully for department: " + department)
                .data(employees)
                .build();
        
        return ResponseEntity.ok(response);
    }

    @Operation(
        summary = "Health check",
        description = "Simple endpoint to verify that the Employee API service is running and healthy"
    )
    @ApiResponses(value = {
        @io.swagger.v3.oas.annotations.responses.ApiResponse(
            responseCode = "200", 
            description = "API is healthy and operational"
        )
    })
    @GetMapping("/health")
    public ResponseEntity<ApiResponse<String>> healthCheck() {
        ApiResponse<String> response = ApiResponse.<String>builder()
                .success(true)
                .message("Employee API is healthy")
                .data("OK")
                .build();
        
        return ResponseEntity.ok(response);
    }
}