package com.employee.management.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * DTO for search parameters
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeSearchRequest {
    private String searchTerm;
    private String department;
    private String position;
    private int page = 0;
    private int size = 10;
    private String sortBy = "lastName";
    private String sortDirection = "ASC";
}