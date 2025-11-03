#!/bin/bash

# Quick Start Script for Employee Management API
# This script builds and starts the application

echo "==================================="
echo "Employee Management API Quick Start"
echo "==================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Check if we're in the right directory
if [ ! -f "pom.xml" ]; then
    print_error "pom.xml not found. Please run this script from the backend directory."
    exit 1
fi

print_info "Starting Employee Management API..."

# Step 1: Clean and compile
print_info "Step 1: Cleaning and compiling the project..."
mvn clean compile
if [ $? -ne 0 ]; then
    print_error "Compilation failed. Please check the errors above."
    exit 1
fi
print_success "Compilation successful!"

# Step 2: Run tests (optional)
read -p "Do you want to run tests before starting? (y/n, default: n): " run_tests
if [[ $run_tests == "y" || $run_tests == "Y" ]]; then
    print_info "Step 2: Running tests..."
    mvn test
    if [ $? -ne 0 ]; then
        print_warning "Tests failed, but continuing with startup..."
    else
        print_success "All tests passed!"
    fi
fi

# Step 3: Package the application
print_info "Step 3: Packaging the application..."
mvn package -DskipTests
if [ $? -ne 0 ]; then
    print_error "Packaging failed. Please check the errors above."
    exit 1
fi
print_success "Packaging successful!"

# Step 4: Start the application
print_success "Build completed successfully!"
print_info "Starting the Spring Boot application..."
print_warning "The application will start on http://localhost:8080"
print_info "API endpoints will be available at http://localhost:8080/api/v1/employees"
print_info "Health check: http://localhost:8080/api/v1/employees/health"
echo
print_info "Press Ctrl+C to stop the application"
print_info "Once started, you can test the API using the curl scripts in ./curl-scripts/"
echo

# Start the application
java -jar target/employee-backend-1.0.0.jar