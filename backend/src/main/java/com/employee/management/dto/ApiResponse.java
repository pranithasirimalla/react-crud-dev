package com.employee.management.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Generic API Response wrapper
 * Provides consistent response structure for all API endpoints
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Schema(description = "Standard API response wrapper that provides consistent structure for all endpoints")
public class ApiResponse<T> {
    @Schema(description = "Indicates whether the API operation was successful", example = "true")
    private boolean success;
    
    @Schema(description = "The main data payload of the response")
    private T data;
    
    @Schema(description = "Human-readable message describing the result", example = "Operation completed successfully")
    private String message;
    
    @Schema(description = "Count of items in the data array (for list responses)", example = "15")
    private Integer count;
    
    @Schema(description = "Error message if the operation failed", example = "Resource not found")
    private String error;
    
    @Builder.Default
    @Schema(description = "ISO 8601 timestamp when the response was generated", example = "2025-11-02T16:30:00.123456789")
    private LocalDateTime timestamp = LocalDateTime.now();

    public ApiResponse(boolean success, T data, String message) {
        this.success = success;
        this.data = data;
        this.message = message;
        this.timestamp = LocalDateTime.now();
    }

    public ApiResponse(boolean success, T data, String message, Integer count) {
        this.success = success;
        this.data = data;
        this.message = message;
        this.count = count;
        this.timestamp = LocalDateTime.now();
    }

    public ApiResponse(boolean success, String message, String error) {
        this.success = success;
        this.message = message;
        this.error = error;
        this.timestamp = LocalDateTime.now();
    }

    // Success response factory methods
    public static <T> ApiResponse<T> success(T data, String message) {
        return new ApiResponse<>(true, data, message);
    }

    public static <T> ApiResponse<T> success(T data, String message, Integer count) {
        return new ApiResponse<>(true, data, message, count);
    }

    public static <T> ApiResponse<T> success(String message) {
        return new ApiResponse<>(true, null, message);
    }

    // Error response factory methods
    public static <T> ApiResponse<T> error(String message, String error) {
        return new ApiResponse<>(false, message, error);
    }

    public static <T> ApiResponse<T> error(String message) {
        return new ApiResponse<>(false, message, null);
    }
}