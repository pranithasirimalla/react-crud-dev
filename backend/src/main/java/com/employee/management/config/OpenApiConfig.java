package com.employee.management.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * OpenAPI (Swagger) configuration for Employee Management API
 * Provides comprehensive API documentation and interactive testing
 */
@Configuration
public class OpenApiConfig {

    @Value("${server.servlet.context-path:/}")
    private String contextPath;

    @Value("${server.port:8080}")
    private String serverPort;

    @Bean
    public OpenAPI employeeManagementOpenAPI() {
        Server server = new Server();
        server.setUrl("http://localhost:" + serverPort + contextPath);
        server.setDescription("Development server");

        Contact contact = new Contact();
        contact.setEmail("developer@company.com");
        contact.setName("Employee Management Team");
        contact.setUrl("https://github.com/your-organization/employee-management");

        License mitLicense = new License()
                .name("MIT License")
                .url("https://choosealicense.com/licenses/mit/");

        Info info = new Info()
                .title("Employee Management API")
                .version("1.0.0")
                .contact(contact)
                .description("A comprehensive REST API for managing employee data, including CRUD operations, search functionality, and hierarchical manager relationships. " +
                           "Built with Spring Boot 3.2.0 and Java 21, featuring PostgreSQL database integration.")
                .termsOfService("https://company.com/terms")
                .license(mitLicense);

        return new OpenAPI()
                .info(info)
                .servers(List.of(server));
    }
}