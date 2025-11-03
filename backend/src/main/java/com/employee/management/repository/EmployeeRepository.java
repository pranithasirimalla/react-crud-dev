package com.employee.management.repository;

import com.employee.management.entity.Employee;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Repository interface for Employee entity
 * Provides CRUD operations and custom query methods
 */
@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer> {

    /**
     * Find employee by email (case-insensitive)
     */
    Optional<Employee> findByEmailIgnoreCase(String email);

    /**
     * Find all active employees
     */
    List<Employee> findByIsActiveTrue();

    /**
     * Find all inactive employees
     */
    List<Employee> findByIsActiveFalse();

    /**
     * Find employees by department (case-insensitive)
     */
    List<Employee> findByDepartmentIgnoreCaseAndIsActiveTrue(String department);

    /**
     * Find employees by position (case-insensitive)
     */
    List<Employee> findByPositionIgnoreCaseAndIsActiveTrue(String position);

    /**
     * Find employees by manager ID
     */
    List<Employee> findByManagerIdAndIsActiveTrue(Integer managerId);

    /**
     * Find employees hired between dates
     */
    List<Employee> findByHireDateBetweenAndIsActiveTrue(LocalDate startDate, LocalDate endDate);

    /**
     * Find employees with salary in range
     */
    List<Employee> findBySalaryBetweenAndIsActiveTrue(BigDecimal minSalary, BigDecimal maxSalary);

    /**
     * Search employees by name (first name or last name containing the search term)
     */
    @Query("SELECT e FROM Employee e WHERE " +
           "(LOWER(e.firstName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(e.lastName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(CONCAT(e.firstName, ' ', e.lastName)) LIKE LOWER(CONCAT('%', :searchTerm, '%'))) " +
           "AND e.isActive = true")
    List<Employee> searchByName(@Param("searchTerm") String searchTerm);

    /**
     * Search employees by multiple criteria
     */
    @Query("SELECT e FROM Employee e WHERE " +
           "(:searchTerm IS NULL OR " +
           "LOWER(e.firstName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(e.lastName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(e.email) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(e.department) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(e.position) LIKE LOWER(CONCAT('%', :searchTerm, '%'))) " +
           "AND (:department IS NULL OR LOWER(e.department) = LOWER(:department)) " +
           "AND (:position IS NULL OR LOWER(e.position) = LOWER(:position)) " +
           "AND e.isActive = true " +
           "ORDER BY e.lastName, e.firstName")
    Page<Employee> searchEmployees(@Param("searchTerm") String searchTerm,
                                  @Param("department") String department,
                                  @Param("position") String position,
                                  Pageable pageable);

    /**
     * Get all distinct departments
     */
    @Query("SELECT DISTINCT e.department FROM Employee e WHERE e.isActive = true ORDER BY e.department")
    List<String> findAllDistinctDepartments();

    /**
     * Get all distinct positions
     */
    @Query("SELECT DISTINCT e.position FROM Employee e WHERE e.isActive = true ORDER BY e.position")
    List<String> findAllDistinctPositions();

    /**
     * Count employees by department
     */
    @Query("SELECT e.department, COUNT(e) FROM Employee e WHERE e.isActive = true GROUP BY e.department")
    List<Object[]> countEmployeesByDepartment();

    /**
     * Find employees with no manager (top-level employees)
     */
    List<Employee> findByManagerIdIsNullAndIsActiveTrue();

    /**
     * Check if email exists (excluding specific employee ID)
     */
    @Query("SELECT COUNT(e) > 0 FROM Employee e WHERE LOWER(e.email) = LOWER(:email) AND e.id != :excludeId")
    boolean existsByEmailIgnoreCaseAndIdNot(@Param("email") String email, @Param("excludeId") Long excludeId);

    /**
     * Check if email exists
     */
    boolean existsByEmailIgnoreCase(String email);

    /**
     * Check if email exists excluding specific ID
     */
    boolean existsByEmailIgnoreCaseAndIdNot(String email, Integer id);

    /**
     * Soft delete employee by setting isActive to false
     */
    @Query("UPDATE Employee e SET e.isActive = false WHERE e.id = :id")
    void softDeleteById(@Param("id") Integer id);

    /**
     * Find employees with pagination and sorting (active only)
     */
    Page<Employee> findByIsActiveTrue(Pageable pageable);
}