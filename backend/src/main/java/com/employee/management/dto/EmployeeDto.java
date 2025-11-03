package com.employee.management.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Data Transfer Object for Employee entity
 * Used for API responses
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "Employee information returned by the API")
public class EmployeeDto {
    @Schema(description = "Unique employee identifier", example = "1")
    private Integer id;
    
    @Schema(description = "Employee's first name", example = "John")
    private String firstName;
    
    @Schema(description = "Employee's last name", example = "Smith")
    private String lastName;
    
    @Schema(description = "Employee's full name", example = "John Smith")
    private String fullName;
    
    @Schema(description = "Employee's email address", example = "john.smith@company.com")
    private String email;
    
    @Schema(description = "Employee's phone number", example = "+1-555-0001")
    private String phone;
    
    @Schema(description = "Employee's department", example = "Engineering")
    private String department;
    
    @Schema(description = "Employee's job position", example = "Senior Software Engineer")
    private String position;
    
    @Schema(description = "Employee's salary", example = "95000.00")
    private BigDecimal salary;
    
    @Schema(description = "Employee's hire date", example = "2024-01-15")
    private LocalDate hireDate;
    
    @Schema(description = "ID of the employee's manager", example = "2")
    private Integer managerId;
    
    @Schema(description = "Full name of the employee's manager", example = "Sarah Johnson")
    private String managerName;
    
    @Schema(description = "Whether the employee is active", example = "true")
    private Boolean isActive;
    
    @Schema(description = "When the employee record was created", example = "2024-01-15T09:00:00")
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}