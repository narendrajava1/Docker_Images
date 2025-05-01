Here’s a clean and functional `docker-compose.yml` file to run **MySQL** using Docker Compose.

---

### ✅ **Docker Compose for MySQL 8**

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    container_name: mysql
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: mydb
      MYSQL_USER: myuser
      MYSQL_PASSWORD: myuserpassword
    volumes:
      - mysql-data:/var/lib/mysql
    restart: unless-stopped

volumes:
  mysql-data:
```

---

### 🔐 Default Connection Details

| Property         | Value             |
|------------------|-------------------|
| Host             | `localhost`       |
| Port             | `3306`            |
| Root user        | `root`            |
| Root password    | `rootpassword`    |
| Database         | `mydb`            |
| App user         | `myuser`          |
| App password     | `myuserpassword`  |

---

### 📦 JDBC URL for MySQL

```properties
jdbc:mysql://localhost:3306/mydb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
```

---

Would you like to auto-import `.sql` files on startup or run this in a Kubernetes setup later?