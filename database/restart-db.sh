#!/bin/bash

# PostgreSQL Database Restart Script
# This script restarts the PostgreSQL and pgAdmin services

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔄 Restarting PostgreSQL Database Services...${NC}"
echo "=================================================="

# Check if scripts exist
if [ ! -f "stop-db.sh" ] || [ ! -f "start-db.sh" ]; then
    echo -e "${RED}❌ Required scripts (stop-db.sh, start-db.sh) not found.${NC}"
    exit 1
fi

# Stop services first
echo -e "${YELLOW}🛑 Stopping services...${NC}"
./stop-db.sh

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${YELLOW}⏳ Waiting 3 seconds before restart...${NC}"
    sleep 3
    
    # Start services
    echo -e "${YELLOW}🚀 Starting services...${NC}"
    ./start-db.sh
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}🎉 Services restarted successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to start services after stop.${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ Failed to stop services. Restart aborted.${NC}"
    exit 1
fi