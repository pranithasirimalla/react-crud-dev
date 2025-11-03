package com.employee.management.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Request DTO for creating and updating employees
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "Employee data for creating or updating employee records")
public class EmployeeRequest {

    @NotBlank(message = "First name is required")
    @Size(max = 50, message = "First name cannot exceed 50 characters")
    @Schema(description = "Employee's first name", example = "John", required = true)
    private String firstName;

    @NotBlank(message = "Last name is required")
    @Size(max = 50, message = "Last name cannot exceed 50 characters")
    @Schema(description = "Employee's last name", example = "Smith", required = true)
    private String lastName;

    @Email(message = "Email should be valid")
    @NotBlank(message = "Email is required")
    @Size(max = 100, message = "Email cannot exceed 100 characters")
    @Schema(description = "Employee's email address", example = "john.smith@company.com", required = true)
    private String email;

    @Size(max = 20, message = "Phone number cannot exceed 20 characters")
    @Schema(description = "Employee's phone number", example = "+1-555-0001")
    private String phone;

    @NotBlank(message = "Department is required")
    @Size(max = 50, message = "Department cannot exceed 50 characters")
    private String department;

    @NotBlank(message = "Position is required")
    @Size(max = 100, message = "Position cannot exceed 100 characters")
    private String position;

    @DecimalMin(value = "0.0", inclusive = false, message = "Salary must be greater than 0")
    @Digits(integer = 8, fraction = 2, message = "Salary format is invalid")
    private BigDecimal salary;

    private LocalDate hireDate;

    private Integer managerId;

    private Boolean isActive = true;
}