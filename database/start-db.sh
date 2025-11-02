#!/bin/bash

# PostgreSQL Database Startup Script
# This script starts the PostgreSQL and pgAdmin services using Docker Compose

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🐳 Starting PostgreSQL Database Services...${NC}"
echo "=================================================="

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not available. Please ensure Docker Desktop is running and WSL integration is enabled.${NC}"
    exit 1
fi

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo -e "${RED}❌ docker-compose.yml not found. Please run this script from the database directory.${NC}"
    exit 1
fi

# Start the services
echo -e "${YELLOW}🚀 Starting services...${NC}"
docker compose up -d

# Check if services started successfully
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Services started successfully!${NC}"
    echo ""
    
    # Wait a moment for services to be ready
    echo -e "${YELLOW}⏳ Waiting for services to be ready...${NC}"
    sleep 5
    
    # Show running containers
    echo -e "${BLUE}📊 Running containers:${NC}"
    docker compose ps
    
    echo ""
    echo -e "${GREEN}🎉 Database setup complete!${NC}"
    echo ""
    echo -e "${BLUE}📝 Service Information:${NC}"
    echo "=================================================="
    echo -e "🗄️  PostgreSQL Database:"
    echo "   • URL: localhost:5432"
    echo "   • Database: employee_db"
    echo "   • Username: admin"
    echo "   • Password: admin123"
    echo ""
    echo -e "🖥️  pgAdmin Web UI:"
    echo "   • URL: http://localhost:8080"
    echo "   • Email: admin@example.com"
    echo "   • Password: admin123"
    echo ""
    echo -e "${YELLOW}💡 To connect pgAdmin to PostgreSQL:${NC}"
    echo "   • Host: postgresdb"
    echo "   • Port: 5432"
    echo "   • Database: employee_db"
    echo "   • Username: admin"
    echo "   • Password: admin123"
    echo ""
    echo -e "${BLUE}📋 Useful commands:${NC}"
    echo "   • View logs: docker compose logs -f"
    echo "   • Stop services: ./stop-db.sh"
    echo "   • Restart services: ./stop-db.sh && ./start-db.sh"
    echo ""
else
    echo -e "${RED}❌ Failed to start services. Please check Docker and try again.${NC}"
    echo ""
    echo -e "${YELLOW}💡 Troubleshooting tips:${NC}"
    echo "   • Ensure Docker Desktop is running"
    echo "   • Check WSL integration is enabled in Docker Desktop settings"
    echo "   • Try: docker compose logs for error details"
    exit 1
fi