#!/bin/bash

# PostgreSQL Database Stop Script
# This script stops the PostgreSQL and pgAdmin services using Docker Compose

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🛑 Stopping PostgreSQL Database Services...${NC}"
echo "=================================================="

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not available. Please ensure Docker Desktop is running.${NC}"
    exit 1
fi

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo -e "${RED}❌ docker-compose.yml not found. Please run this script from the database directory.${NC}"
    exit 1
fi

# Show current running containers before stopping
echo -e "${BLUE}📊 Current running containers:${NC}"
docker compose ps

echo ""
echo -e "${YELLOW}🛑 Stopping services...${NC}"

# Stop the services
docker compose down

# Check if services stopped successfully
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Services stopped successfully!${NC}"
    echo ""
    echo -e "${BLUE}📝 Service Status:${NC}"
    echo "=================================================="
    echo "🗄️  PostgreSQL Database: Stopped"
    echo "🖥️  pgAdmin Web UI: Stopped"
    echo ""
    echo -e "${YELLOW}💡 Data persistence:${NC}"
    echo "   • Your database data is safely stored in the 'data/' folder"
    echo "   • pgAdmin settings are preserved in Docker volume"
    echo "   • All data will be restored when you restart services"
    echo ""
    echo -e "${BLUE}📋 Useful commands:${NC}"
    echo "   • Start services: ./start-db.sh"
    echo "   • View stopped containers: docker compose ps -a"
    echo "   • Remove all data (⚠️  destructive): docker compose down -v"
    echo ""
else
    echo -e "${RED}❌ Failed to stop services properly.${NC}"
    echo ""
    echo -e "${YELLOW}💡 Manual cleanup options:${NC}"
    echo "   • Force stop: docker compose kill"
    echo "   • Remove containers: docker compose rm -f"
    echo "   • View running processes: docker ps"
    exit 1
fi

# Optionally show system resources freed
echo -e "${GREEN}🧹 System resources have been freed up.${NC}"