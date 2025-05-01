Here’s a simple and production-ready `docker-compose.yml` file to run **Microsoft SQL Server (MSSQL)** on Docker using Docker Compose.

---

### ✅ **Docker Compose File for SQL Server 2019 or 2022**

```yaml
version: '3.8'

services:
  mssql:
    image: mcr.microsoft.com/mssql/server:2022-latest
    container_name: mssql
    ports:
      - 1433:1433
    environment:
      SA_PASSWORD: "YourStrong!Passw0rd"
      ACCEPT_EULA: "Y"
    volumes:
      - mssql-data:/var/opt/mssql
    restart: unless-stopped

volumes:
  mssql-data:
```

---

### 🔐 Default Connection Details

- **Host**: `localhost`
- **Port**: `1433`
- **Username**: `sa`
- **Password**: `YourStrong!Passw0rd`
- **DB**: Connect to the `master` DB initially

You can connect via:
- **DBeaver**
- **Azure Data Studio**
- **SQL Server Management Studio (SSMS)**

---

### 📦 JDBC URL for MSSQL

```properties
jdbc:sqlserver://localhost:1433;databaseName=master;user=sa;password=YourStrong!Passw0rd;
```

---

Let me know if you want to:
- Auto-create a new database on startup
- Add user-defined databases or scripts
- Use SQL Server Developer Edition instead of Express