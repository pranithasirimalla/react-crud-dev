#!/bin/bash

# PostgreSQL Database Status Script
# This script shows the current status of PostgreSQL and pgAdmin services

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📊 PostgreSQL Database Services Status${NC}"
echo "=================================================="

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not available.${NC}"
    exit 1
fi

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo -e "${RED}❌ docker-compose.yml not found. Please run this script from the database directory.${NC}"
    exit 1
fi

# Show container status
echo -e "${BLUE}🐳 Container Status:${NC}"
docker compose ps

echo ""

# Check if services are running
POSTGRES_RUNNING=$(docker compose ps -q postgresdb 2>/dev/null)
PGADMIN_RUNNING=$(docker compose ps -q postgresui 2>/dev/null)

if [ ! -z "$POSTGRES_RUNNING" ] && [ "$(docker inspect -f '{{.State.Status}}' $POSTGRES_RUNNING 2>/dev/null)" == "running" ]; then
    echo -e "${GREEN}✅ PostgreSQL Database: Running${NC}"
    
    # Test database connection
    echo -e "${YELLOW}🔌 Testing database connection...${NC}"
    if docker compose exec -T postgresdb pg_isready -U admin -d employee_db &>/dev/null; then
        echo -e "${GREEN}   ✓ Database is accepting connections${NC}"
        
        # Get employee count
        EMPLOYEE_COUNT=$(docker compose exec -T postgresdb psql -U admin -d employee_db -t -c "SELECT COUNT(*) FROM employees;" 2>/dev/null | xargs)
        if [ ! -z "$EMPLOYEE_COUNT" ] && [ "$EMPLOYEE_COUNT" -gt 0 ]; then
            echo -e "${GREEN}   ✓ Employee table exists with $EMPLOYEE_COUNT records${NC}"
        fi
    else
        echo -e "${RED}   ✗ Database is not accepting connections${NC}"
    fi
else
    echo -e "${RED}❌ PostgreSQL Database: Not Running${NC}"
fi

if [ ! -z "$PGADMIN_RUNNING" ] && [ "$(docker inspect -f '{{.State.Status}}' $PGADMIN_RUNNING 2>/dev/null)" == "running" ]; then
    echo -e "${GREEN}✅ pgAdmin Web UI: Running${NC}"
    echo -e "${BLUE}   🌐 Access at: http://localhost:8080${NC}"
else
    echo -e "${RED}❌ pgAdmin Web UI: Not Running${NC}"
fi

echo ""

# Show service endpoints if running
if [ ! -z "$POSTGRES_RUNNING" ] && [ ! -z "$PGADMIN_RUNNING" ]; then
    echo -e "${BLUE}📝 Service Information:${NC}"
    echo "=================================================="
    echo -e "🗄️  PostgreSQL Database:"
    echo "   • Host: localhost:5432"
    echo "   • Database: employee_db"
    echo "   • Username: admin"
    echo "   • Password: admin123"
    echo ""
    echo -e "🖥️  pgAdmin Web UI:"
    echo "   • URL: http://localhost:8080"
    echo "   • Email: admin@example.com"
    echo "   • Password: admin123"
    echo ""
fi

# Show logs option
echo -e "${BLUE}📋 Available Commands:${NC}"
echo "   • Start services: ./start-db.sh"
echo "   • Stop services: ./stop-db.sh"
echo "   • View logs: docker compose logs -f"
echo "   • View PostgreSQL logs only: docker compose logs -f postgresdb"
echo "   • View pgAdmin logs only: docker compose logs -f postgresui"