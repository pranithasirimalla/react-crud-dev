# Backend - Java 17/Spring Boot

This directory will contain the Spring Boot backend API for the employee management system.

## 🚀 Getting Started

### Prerequisites
- Java 17 (JDK)
- Maven 3.6+ or Gradle 7.0+
- PostgreSQL database (use Docker setup from ../database)
- IDE (IntelliJ IDEA, Eclipse, or VS Code with Java extensions)

### Installation
```bash
# Create Spring Boot project using Spring Initializr or Maven
mvn archetype:generate -DgroupId=com.employee.management \
  -DartifactId=employee-backend \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false

# Or initialize with Spring Boot CLI
spring init --dependencies=web,data-jpa,postgresql,validation,security \
  --java-version=17 --type=maven-project employee-backend
```

## 📋 Planned Features

### API Endpoints
```
GET    /api/employees          # Get all employees
GET    /api/employees/{id}     # Get employee by ID
POST   /api/employees          # Create new employee
PUT    /api/employees/{id}     # Update employee
DELETE /api/employees/{id}     # Delete employee (soft delete)
GET    /api/employees/search   # Search employees
GET    /api/departments        # Get all departments
```

### Spring Boot Features
- **Spring Web** - RESTful web services
- **Spring Data JPA** - Database operations
- **Spring Security** - Authentication and authorization
- **Spring Validation** - Input validation
- **CORS Configuration** - Cross-origin resource sharing
- **Exception Handling** - Global exception handling with @ControllerAdvice
- **Actuator** - Health checks and monitoring

## 🗄️ Database Integration

### Connection Configuration
```yaml
# application.yml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/employee_db
    username: admin
    password: admin123
    driver-class-name: org.postgresql.Driver
  
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true

server:
  port: 8080
```

### Maven Dependencies (pom.xml)
```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
        <groupId>org.postgresql</groupId>
        <artifactId>postgresql</artifactId>
        <scope>runtime</scope>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-validation</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
</dependencies>
```

## 📂 Planned Structure

```
src/
└── main/
    ├── java/
    │   └── com/employee/management/
    │       ├── EmployeeManagementApplication.java
    │       ├── config/
    │       │   ├── SecurityConfig.java
    │       │   └── CorsConfig.java
    │       ├── controller/
    │       │   └── EmployeeController.java
    │       ├── service/
    │       │   ├── EmployeeService.java
    │       │   └── EmployeeServiceImpl.java
    │       ├── repository/
    │       │   └── EmployeeRepository.java
    │       ├── entity/
    │       │   ├── Employee.java
    │       │   └── Department.java
    │       ├── dto/
    │       │   ├── EmployeeDto.java
    │       │   └── EmployeeRequest.java
    │       └── exception/
    │           ├── GlobalExceptionHandler.java
    │           └── ResourceNotFoundException.java
    └── resources/
        ├── application.yml
        └── data.sql
└── test/
    └── java/
        └── com/employee/management/
            └── EmployeeControllerTest.java
```

## 🔒 Security Features

- **Spring Security** - Authentication and authorization
- **Input Validation** - Bean validation with annotations
- **SQL Injection Prevention** - JPA/Hibernate parameterized queries
- **CORS Configuration** - Cross-origin request handling
- **Exception Handling** - Global exception handling
- **Security Headers** - Automatic security headers
- **Method Security** - @PreAuthorize and @Secured annotations

## 📊 Sample Controller

```java
// controller/EmployeeController.java
@RestController
@RequestMapping("/api/employees")
@CrossOrigin(origins = "http://localhost:3000")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<EmployeeDto>>> getAllEmployees() {
        try {
            List<EmployeeDto> employees = employeeService.getAllEmployees();
            ApiResponse<List<EmployeeDto>> response = new ApiResponse<>(
                true, 
                employees, 
                "Employees retrieved successfully",
                employees.size()
            );
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            ApiResponse<List<EmployeeDto>> response = new ApiResponse<>(
                false, 
                null, 
                "Error fetching employees: " + e.getMessage(),
                0
            );
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<EmployeeDto>> getEmployeeById(@PathVariable Long id) {
        EmployeeDto employee = employeeService.getEmployeeById(id);
        ApiResponse<EmployeeDto> response = new ApiResponse<>(
            true, 
            employee, 
            "Employee retrieved successfully",
            1
        );
        return ResponseEntity.ok(response);
    }

    @PostMapping
    public ResponseEntity<ApiResponse<EmployeeDto>> createEmployee(@Valid @RequestBody EmployeeRequest request) {
        EmployeeDto employee = employeeService.createEmployee(request);
        ApiResponse<EmployeeDto> response = new ApiResponse<>(
            true, 
            employee, 
            "Employee created successfully",
            1
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}
```

## 🧪 Testing

### Test Dependencies
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>test</scope>
</dependency>
```

### Sample Test
```java
// test/java/com/employee/management/EmployeeControllerTest.java
@SpringBootTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.ANY)
@TestPropertySource(locations = "classpath:application-test.properties")
class EmployeeControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void getAllEmployees_ShouldReturnEmployeeList() throws Exception {
        mockMvc.perform(get("/api/employees"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data").isArray());
    }

    @Test
    void createEmployee_WithValidData_ShouldReturnCreatedEmployee() throws Exception {
        String employeeJson = "{"
                + "\"firstName\":\"John\","
                + "\"lastName\":\"Doe\","
                + "\"email\":\"john.doe@example.com\","
                + "\"department\":\"IT\","
                + "\"position\":\"Developer\""
                + "}";

        mockMvc.perform(post("/api/employees")
                .contentType(MediaType.APPLICATION_JSON)
                .content(employeeJson))
                .andExpect(status().isCreated())
                .andExpected(jsonPath("$.success").value(true));
    }
}
```

## 📋 Maven Commands

```bash
# Build the project
mvn clean compile

# Run tests
mvn test

# Run the application
mvn spring-boot:run

# Package as JAR
mvn clean package

# Run with specific profile
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

## 🔄 API Response Format

### Success Response
```json
{
  "success": true,
  "data": [...],
  "message": "Operation completed successfully",
  "count": 10
}
```

### Error Response
```json
{
  "success": false,
  "message": "Error description",
  "error": "Detailed error information",
  "timestamp": "2024-11-02T10:30:00Z"
}
```

## 🏗️ Entity Example

```java
// entity/Employee.java
@Entity
@Table(name = "employees")
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name", nullable = false)
    @NotBlank(message = "First name is required")
    private String firstName;

    @Column(name = "last_name", nullable = false)
    @NotBlank(message = "Last name is required")
    private String lastName;

    @Column(unique = true, nullable = false)
    @Email(message = "Email should be valid")
    private String email;

    @Column(nullable = false)
    private String department;

    @Column(nullable = false)
    private String position;

    @Column(precision = 10, scale = 2)
    private BigDecimal salary;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @CreationTimestamp
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Constructors, getters, and setters
}
```

---

*This Spring Boot backend will provide a robust, secure, and scalable API for the employee management system using modern Java practices and Spring ecosystem.*