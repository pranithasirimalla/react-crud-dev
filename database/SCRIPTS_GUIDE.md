# Database Management Scripts

## 📋 Available Scripts

This directory contains convenient bash scripts to manage your PostgreSQL database environment:

| Script | Purpose | Usage |
|--------|---------|-------|
| `start-db.sh` | Start all database services | `./start-db.sh` |
| `stop-db.sh` | Stop all database services | `./stop-db.sh` |
| `status-db.sh` | Check service status | `./status-db.sh` |
| `restart-db.sh` | Restart all services | `./restart-db.sh` |

## 🚀 Quick Start

1. **Start the database:**
   ```bash
   ./start-db.sh
   ```

2. **Check if everything is running:**
   ```bash
   ./status-db.sh
   ```

3. **Access the web UI:**
   - Open http://localhost:8080 in your browser
   - Login with: `admin@example.com` / `admin123`

## 📊 Script Features

### start-db.sh
- ✅ Validates Docker availability
- 🐳 Starts PostgreSQL and pgAdmin containers
- ⏳ Waits for services to be ready
- 📊 Shows container status
- 💡 Displays connection information
- 🎯 Provides next-step guidance

### stop-db.sh  
- 🛑 Gracefully stops all services
- 💾 Preserves all data and settings
- 🧹 Cleans up system resources
- 📋 Shows useful commands for restart

### status-db.sh
- 📊 Shows real-time container status
- 🔌 Tests database connectivity
- 📈 Displays employee record count
- 🌐 Shows service endpoints
- 📋 Lists available commands

### restart-db.sh
- 🔄 Performs clean service restart
- ⏸️ Stops services gracefully
- ⏳ Includes proper wait intervals
- 🚀 Starts services fresh

## 🛠️ Troubleshooting

If scripts don't work:

1. **Check Docker:**
   ```bash
   docker --version
   docker compose version
   ```

2. **Enable WSL integration:**
   - Open Docker Desktop
   - Settings → Resources → WSL Integration
   - Enable for your WSL distro

3. **Check script permissions:**
   ```bash
   ls -la *.sh
   # Should show -rwxr-xr-x permissions
   ```

4. **Make scripts executable (if needed):**
   ```bash
   chmod +x *.sh
   ```

## 📂 File Structure After Setup

```
database/
├── start-db.sh          # 🚀 Start services
├── stop-db.sh           # 🛑 Stop services  
├── status-db.sh         # 📊 Check status
├── restart-db.sh        # 🔄 Restart services
├── docker-compose.yml   # 🐳 Docker configuration
├── data/               # 💾 Persistent database data
├── schema/             # 📋 Database schema files
├── seed-data/          # 🌱 Initial data files
└── readme.md           # 📖 Documentation
```

## 🎯 Next Steps

1. Run `./start-db.sh` to start your database
2. Open http://localhost:8080 for pgAdmin
3. Connect to PostgreSQL using the provided credentials
4. Start building your React CRUD application!

---
*All scripts include colorized output and comprehensive error handling for a smooth development experience.*