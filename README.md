# 4.8

## Useful Docker Compose Commands

# Build images and start all services in the background
docker compose up -d --build

# Start all services in the background
docker compose up -d

# Stop all services (containers remain)
docker compose stop

# Start stopped services
docker compose start

# Stop and remove containers and network (volumes are kept)
docker compose down

# Stop and remove everything including volumes (data lost!)
docker compose down -v

# View logs from all services
docker compose logs

# View logs from one service
docker compose logs app

# Follow logs in real time
docker compose logs -f

# View services and their status
docker compose ps

# Restart one service
docker compose restart app

# Open a PostgreSQL shell in the db container
docker compose exec db psql -U postgres -d simplecrmlite

# Open a shell in the app container
docker compose exec app /bin/sh

# List volumes
docker volume ls

# View resource usage
docker stats


## Part 4: Test the CRUD API
## Part 5: Prove the Data Persists


shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker build -t simple-crm-lite:latest .
[+] Building 68.1s (17/17) FINISHED                                                        docker:default
 => [internal] load build definition from Dockerfile                                                 0.0s
 => => transferring dockerfile: 765B                                                                 0.0s
 => [internal] load metadata for docker.io/library/eclipse-temurin:21-jre-alpine                     2.9s
 => [internal] load metadata for docker.io/library/maven:3.9-eclipse-temurin-21                      1.9s
 => [auth] library/eclipse-temurin:pull token for registry-1.docker.io                               0.0s
 => [auth] library/maven:pull token for registry-1.docker.io                                         0.0s
 => [internal] load .dockerignore                                                                    0.0s
 => => transferring context: 2B                                                                      0.0s
 => [build 1/6] FROM docker.io/library/maven:3.9-eclipse-temurin-21@sha256:99e61abcff91a9b1333463bd  0.0s
 => => resolve docker.io/library/maven:3.9-eclipse-temurin-21@sha256:99e61abcff91a9b1333463bd8451fb  0.0s
 => [internal] load build context                                                                    0.0s
 => => transferring context: 10.29kB                                                                 0.0s
 => [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665  15.7s
 => => resolve docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8  0.0s
 => => extracting sha256:e2de96513ba9eb53b431787ec8a65cdde380ac4772a3e4c4b714dcfde2a102b5            0.2s
 => => sha256:5abc2579d091ef7359d2654aa76115280a45a0c81c04e644017e6cb1ef45295b 2.46kB / 2.46kB       0.3s
 => => sha256:b3405c83ad56324f504856a713a1a5d6c28d82a78170a4dd4097c209f8517c18 128B / 128B           0.5s
 => => sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96 16.97MB / 16.97MB     9.6s
 => => sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221 53.26MB / 53.26MB    14.7s
 => => extracting sha256:8d3daccf082f0d6dd742c035c3462b3d39cf08cfd1ab9f511c1d592fa15d8d96            0.6s
 => => extracting sha256:2242b49db9769393ae8d0d9f9742407ad40a7611accc1c189f0ffac0a0530221            0.8s
 => => extracting sha256:b3405c83ad56324f504856a713a1a5d6c28d82a78170a4dd4097c209f8517c18            0.0s
 => => extracting sha256:5abc2579d091ef7359d2654aa76115280a45a0c81c04e644017e6cb1ef45295b            0.0s
 => CACHED [build 2/6] WORKDIR /app                                                                  0.0s
 => [build 3/6] COPY pom.xml .                                                                       0.0s
 => [build 4/6] RUN mvn dependency:go-offline -B                                                    57.9s
 => [stage-1 2/3] WORKDIR /app                                                                       0.1s
 => [build 5/6] COPY src ./src                                                                       0.1s
 => [build 6/6] RUN mvn clean package -DskipTests                                                    4.0s
 => [stage-1 3/3] COPY --from=build /app/target/simple-crm-lite-0.0.1-SNAPSHOT.jar app.jar           0.1s
 => exporting to image                                                                               2.9s
 => => exporting layers                                                                              1.3s
 => => exporting manifest sha256:ff483c070d0f6a5e4a81dea7e38db94a0f21948d58dcfb7ea44d9df61a445cbf    0.0s
 => => exporting config sha256:05ddad2ca410baaeb8199e4a6367610eaed6bf1f967e59f1e54d25d4207d34bf      0.0s
 => => exporting attestation manifest sha256:5826d10bbec3328e350b23a03b1769377076d50643c23ec70a5ccf  0.0s
 => => exporting manifest list sha256:db63556c2f8845470d9b2ca2e45902b896c460851954ec4cde2bd5ea0a990  0.0s
 => => naming to docker.io/library/simple-crm-lite:latest                                            0.0s
 => => unpacking to docker.io/library/simple-crm-lite:latest                                         1.4s
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker images | grep simple-crm-lite
simple-crm-lite:latest         db63556c2f88        383MB          120MB
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose up -d --build
[+] up 13/13
 ✔ Image postgres:16-alpine Pulled                                                                   10.4s
[+] Building 1.5s (17/17) FINISHED
 => [internal] load local bake definitions                                                           0.0s
 => => reading from stdin 538B                                                                       0.0s
 => [internal] load build definition from Dockerfile                                                 0.0s
 => => transferring dockerfile: 765B                                                                 0.0s
 => [internal] load metadata for docker.io/library/eclipse-temurin:21-jre-alpine                     0.9s
 => [internal] load metadata for docker.io/library/maven:3.9-eclipse-temurin-21                      0.9s
 => [internal] load .dockerignore                                                                    0.0s
 => => transferring context: 2B                                                                      0.0s
 => [build 1/6] FROM docker.io/library/maven:3.9-eclipse-temurin-21@sha256:99e61abcff91a9b1333463bd  0.0s
 => => resolve docker.io/library/maven:3.9-eclipse-temurin-21@sha256:99e61abcff91a9b1333463bd8451fb  0.0s
 => [internal] load build context                                                                    0.0s
 => => transferring context: 1.32kB                                                                  0.0s
 => [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665c  0.0s
 => => resolve docker.io/library/eclipse-temurin:21-jre-alpine@sha256:51ab5e3302e7141ce665ca3ea85e8  0.0s
 => CACHED [stage-1 2/3] WORKDIR /app                                                                0.0s
 => CACHED [build 2/6] WORKDIR /app                                                                  0.0s
 => CACHED [build 3/6] COPY pom.xml .                                                                0.0s
 => CACHED [build 4/6] RUN mvn dependency:go-offline -B                                              0.0s
 => CACHED [build 5/6] COPY src ./src                                                                0.0s
 => CACHED [build 6/6] RUN mvn clean package -DskipTests                                             0.0s
 => CACHED [stage-1 3/3] COPY --from=build /app/target/simple-crm-lite-0.0.1-SNAPSHOT.jar app.jar    0.0s
 => exporting to image                                                                               0.1s
 => => exporting layers                                                                              0.0s
 => => exporting manifest sha256:1e098d1f0ba7639fe421cc54e75b08e5861e53fffc282978aa0cf1f0bb729e5a    0.0s
 => => exporting config sha256:3fbe688c9c513a0cf04ac27ac6cf222256234738b410652442ff950f5d1eec7a      0.0s
 => => exporting attestation manifest sha256:265ef66b5d96eb45ce58201f4d87f4c586a515cbe76c2cf82deabe  0.0s
 => => exporting manifest list sha256:a1dd8fb626fe9b455a0b42c176a0649f1b2bb8c691710970682b66444c190  0.0s
 => => naming to docker.io/library/simple-crm-lite-app:latest                                        0.0s
[+] up 18/18king to docker.io/library/simple-crm-lite-app:latest                                     0.0s
 ✔ Image postgres:16-alpine             Pulled                                                       10.4s
 ✔ Image simple-crm-lite-app            Built                                                         1.7s
 ✔ Network simple-crm-lite_default      Created                                                       0.0s
 ✔ Volume simple-crm-lite_postgres-data Created                                                       0.0s
 ✔ Container simple-crm-lite-db         Healthy                                                      11.2s
 ✔ Container simple-crm-lite-app        Started                                                      11.2s
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose logs -f app
simple-crm-lite-app  |
simple-crm-lite-app  |   .   ____          _            __ _ _
simple-crm-lite-app  |  /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
simple-crm-lite-app  | ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
simple-crm-lite-app  |  \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
simple-crm-lite-app  |   '  |____| .__|_| |_|_| |_\__, | / / / /
simple-crm-lite-app  |  =========|_|==============|___/=/_/_/_/
simple-crm-lite-app  |
simple-crm-lite-app  |  :: Spring Boot ::                (v4.1.1)
simple-crm-lite-app  |
simple-crm-lite-app  | 2026-10-10T01:43:45.833Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : Starting SimpleCrmLiteApplication v0.0.1-SNAPSHOT using Java 21.0.12.1 with PID 1 (/app/app.jar started by root in /app)
simple-crm-lite-app  | 2026-10-10T01:43:45.838Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : No active profile set, falling back to 1 default profile: "default"
simple-crm-lite-app  | 2026-10-10T01:43:46.500Z  INFO 1 --- [simple-crm-lite] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data JPA repositories in DEFAULT mode.
simple-crm-lite-app  | 2026-10-10T01:43:46.557Z  INFO 1 --- [simple-crm-lite] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 48 ms. Found 1 JPA repository interface.
simple-crm-lite-app  | 2026-10-10T01:43:47.097Z  INFO 1 --- [simple-crm-lite] [           main] o.s.boot.tomcat.TomcatWebServer          : Tomcat initialized with port 8080 (http)
simple-crm-lite-app  | 2026-10-10T01:43:47.113Z  INFO 1 --- [simple-crm-lite] [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
simple-crm-lite-app  | 2026-10-10T01:43:47.113Z  INFO 1 --- [simple-crm-lite] [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/11.0.24]
simple-crm-lite-app  | 2026-10-10T01:43:47.141Z  INFO 1 --- [simple-crm-lite] [           main] b.w.c.s.WebApplicationContextInitializer : Root WebApplicationContext: initialization completed in 1248 ms
simple-crm-lite-app  | 2026-10-10T01:43:47.318Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.jpa                    : HHH008540: Processing PersistenceUnitInfo [name: default]
simple-crm-lite-app  | 2026-10-10T01:43:47.378Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.core                   : HHH000001: Hibernate ORM core version 7.4.5.Final
simple-crm-lite-app  | 2026-10-10T01:43:47.849Z  INFO 1 --- [simple-crm-lite] [           main] o.s.o.j.p.SpringPersistenceUnitInfo      : No LoadTimeWeaver setup: ignoring JPA class transformer
simple-crm-lite-app  | 2026-10-10T01:43:47.889Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
simple-crm-lite-app  | 2026-10-10T01:43:48.126Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added connection org.postgresql.jdbc.PgConnection@445058e8
simple-crm-lite-app  | 2026-10-10T01:43:48.128Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start completed.
simple-crm-lite-app  | 2026-10-10T01:43:48.217Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.connections.pooling    : HHH10001005: Database info:
simple-crm-lite-app  |  Database JDBC URL [jdbc:postgresql://db:5432/simplecrmlite]
simple-crm-lite-app  |  Database driver: PostgreSQL JDBC Driver
simple-crm-lite-app  |  Database dialect: PostgreSQLDialect
simple-crm-lite-app  |  Database version: 16.15
simple-crm-lite-app  |  Default catalog/schema: simplecrmlite/public
simple-crm-lite-app  |  Autocommit mode: undefined/unknown
simple-crm-lite-app  |  Isolation level: READ_COMMITTED [default READ_COMMITTED]
simple-crm-lite-app  |  JDBC fetch size: none
simple-crm-lite-app  |  Pool: DataSourceConnectionProvider
simple-crm-lite-app  |  Minimum pool size: undefined/unknown
simple-crm-lite-app  |  Maximum pool size: undefined/unknown
simple-crm-lite-app  | 2026-10-10T01:43:49.102Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.core                   : HHH000489: No JTA platform available (set 'hibernate.transaction.jta.platform' to enable JTA platform integration)
simple-crm-lite-app  | Hibernate: create table customer (id bigint generated by default as identity, contact_no varchar(255), email varchar(255), first_name varchar(255), job_title varchar(255), last_name varchar(255), year_of_birth integer, primary key (id))
simple-crm-lite-app  | 2026-10-10T01:43:49.193Z  INFO 1 --- [simple-crm-lite] [           main] j.LocalContainerEntityManagerFactoryBean : Initialized JPA EntityManagerFactory for persistence unit 'default'
simple-crm-lite-app  | 2026-10-10T01:43:49.282Z  INFO 1 --- [simple-crm-lite] [           main] o.s.d.j.r.query.QueryEnhancerFactories   : Hibernate is in classpath; If applicable, HQL parser will be used.
simple-crm-lite-app  | 2026-10-10T01:43:49.401Z  WARN 1 --- [simple-crm-lite] [           main] JpaBaseConfiguration$JpaWebConfiguration : spring.jpa.open-in-view is enabled by default. Therefore, database queries may be performed during view rendering. Explicitly configure spring.jpa.open-in-view to disable this warning
simple-crm-lite-app  | 2026-10-10T01:43:49.698Z  INFO 1 --- [simple-crm-lite] [           main] o.s.boot.tomcat.TomcatWebServer          : Tomcat started on port 8080 (http) with context path '/'
simple-crm-lite-app  | 2026-10-10T01:43:49.741Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : Started SimpleCrmLiteApplication in 4.327 seconds (process running for 4.94)
simple-crm-lite-app  | Hibernate: select count(*) from customer c1_0
simple-crm-lite-app  | Hibernate: insert into customer (contact_no,email,first_name,job_title,last_name,year_of_birth) values (?,?,?,?,?,?)
simple-crm-lite-app  | Hibernate: insert into customer (contact_no,email,first_name,job_title,last_name,year_of_birth) values (?,?,?,?,?,?)
simple-crm-lite-app  | Hibernate: insert into customer (contact_no,email,first_name,job_title,last_name,year_of_birth) values (?,?,?,?,?,?)
simple-crm-lite-app  | ✅ Sample data loaded: 3 customers added
^C

shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose ps
NAME                  IMAGE                 COMMAND                  SERVICE   CREATED          STATUS                    PORTS
simple-crm-lite-app   simple-crm-lite-app   "java -jar app.jar"      app       26 seconds ago   Up 14 seconds             0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp
simple-crm-lite-db    postgres:16-alpine    "docker-entrypoint.s…"   db        26 seconds ago   Up 25 seconds (healthy)   0.0.0.0:5432->5432/tcp, [::]:5432->5432/tcp
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl http://localhost:8080/customers
[{"firstName":"Bruce","lastName":"Wayne","email":"bruce@wayneenterprises.com","contactNo":"11122233","jobTitle":"CEO","yearOfBirth":1975,"id":1},{"firstName":"Diana","lastName":"Prince","email":"diana@themyscira.gov","contactNo":"22233344","jobTitle":"Ambassador","yearOfBirth":1980,"id":2},{"firstName":"Clark","lastName":"Kent","email":"clark@dailyplanet.com","contactNo":"33344455","jobTitle":"Reporter","yearOfBirth":1978,"id":3}]shanli@BlackLoop:~/projects/4.8/simple-crm-litshanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl -X POST http://localhost:8080/customers \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Tony",
    "lastName": "Stark",
    "email": "tony@starkindustries.com",
    "contactNo": "55566677",
    "jobTitle": "CEO",
    "yearOfBirth": 1980
  }'
{"firstName":"Tony","lastName":"Stark","email":"tony@starkindustries.com","contactNo":"55566677","jobTitle":"CEO","yearOshanli@BlackLoop:~/projects/4.8/simple-crm-lite$ .8/sihttp://localhost:8080/customers
[{"firstName":"Bruce","lastName":"Wayne","email":"bruce@wayneenterprises.com","contactNo":"11122233","jobTitle":"CEO","yearOfBirth":1975,"id":1},{"firstName":"Diana","lastName":"Prince","email":"diana@themyscira.gov","contactNo":"22233344","jobTitle":"Ambassador","yearOfBirth":1980,"id":2},{"firstName":"Clark","lastName":"Kent","email":"clark@dailyplanet.com","contactNo":"33344455","jobTitle":"Reporter","yearOfBirth":1978,"id":3},{"firstName":"Tony","lastName":"Stark","email":"tony@starkindustries.com","contactNo":"55566677","jobTitle":"CEO","yearOfBirth":1980,"id":4}]shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl http://localhost:8080/customers/4
{"firstName":"Tony","lastName":"Stark","email":"tony@starkindustries.com","contactNo":"55566677","jobTitle":"CEO","yearOshanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl -X PUT http://localhost:8080/customers/4 \t:8080/customers/4 \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Tony",
    "lastName": "Stark",
    "email": "ironman@starkindustries.com",
    "contactNo": "55566677",
    "jobTitle": "Superhero CEO",
    "yearOfBirth": 1980
  }'
{"firstName":"Tony","lastName":"Stark","email":"ironman@starkindustries.com","contactNo":"55566677","jobTitle":"Superhershanli@BlackLoop:~/projects/4.8/simple-crm-lite$ :~/prhttp://localhost:8080/customers/4
{"firstName":"Tony","lastName":"Stark","email":"ironman@starkindustries.com","contactNo":"55566677","jobTitle":"Superhero CEO","yearOfBirth":1980,"id":4}shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl -X DELETE http://localhost:8080/ccurl -X DELETE http://localhost:8080/customers/4
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl http://localhost:8080/customers/4
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl -i http://localhost:8080/customers/4
HTTP/1.1 404
Content-Length: 0
Date: Sat, 10 Oct 2026 01:47:12 GMT

shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl -X POST http://localhost:8080/customers \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Natasha",
    "lastName": "Romanoff",
    "email": "natasha@shield.gov",
    "contactNo": "44455566",
    "jobTitle": "Agent",
    "yearOfBirth": 1985
  }'
{"firstName":"Natasha","lastName":"Romanoff","email":"natasha@shield.gov","contactNo":"44455566","jobTitle":"Agent","yeashanli@BlackLoop:~/projects/4.8/simple-crm-lite$ /4.8/si http://localhost:8080/customers/5
HTTP/1.1 200
Content-Type: application/json
Transfer-Encoding: chunked
Date: Sat, 10 Oct 2026 01:47:49 GMT

{"firstName":"Natasha","lastName":"Romanoff","email":"natasha@shield.gov","contactNo":"44455566","jobTitle":"Agent","yearOfBirth":1985,"id":5}shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose exec db psql -U postgres -d simplecrmlite \                                        docker compose exec db psql -U postgres -d simplecrmlite \
  -c "SELECT id, first_name, last_name, email FROM customer ORDER BY id;"
 id | first_name | last_name |           email
----+------------+-----------+----------------------------
  1 | Bruce      | Wayne     | bruce@wayneenterprises.com
  2 | Diana      | Prince    | diana@themyscira.gov
  3 | Clark      | Kent      | clark@dailyplanet.com
  5 | Natasha    | Romanoff  | natasha@shield.gov
(4 rows)

shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose exec db psql -U postgres -d simplecrmlite   -c "SELECT id, first_name, last_name, email FROM customer ORDER BY id;"
 id | first_name | last_name |           email
----+------------+-----------+----------------------------
  1 | Bruce      | Wayne     | bruce@wayneenterprises.com
  2 | Diana      | Prince    | diana@themyscira.gov
  3 | Clark      | Kent      | clark@dailyplanet.com
  5 | Natasha    | Romanoff  | natasha@shield.gov
(4 rows)

shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker volume ls
DRIVER    VOLUME NAME
local     devops-demo-460_postgres-data
local     simple-crm-lite_postgres-data
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose down
[+] down 3/3
 ✔ Container simple-crm-lite-app   Removed                                                                          0.4s
 ✔ Container simple-crm-lite-db    Removed                                                                          0.4s
 ✔ Network simple-crm-lite_default Removed                                                                          0.3s
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker volume ls
DRIVER    VOLUME NAME
local     devops-demo-460_postgres-data
local     simple-crm-lite_postgres-data
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose up -d
docker compose logs -f app
[+] up 3/3
 ✔ Network simple-crm-lite_default Created                                                                          0.0s
 ✔ Container simple-crm-lite-db    Healthy                                                                         10.9s
 ✔ Container simple-crm-lite-app   Started                                                                         11.0s
simple-crm-lite-app  |
simple-crm-lite-app  |   .   ____          _            __ _ _
simple-crm-lite-app  |  /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
simple-crm-lite-app  | ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
simple-crm-lite-app  |  \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
simple-crm-lite-app  |   '  |____| .__|_| |_|_| |_\__, | / / / /
simple-crm-lite-app  |  =========|_|==============|___/=/_/_/_/
simple-crm-lite-app  |
simple-crm-lite-app  |  :: Spring Boot ::                (v4.1.1)
simple-crm-lite-app  |
simple-crm-lite-app  | 2026-10-10T01:53:37.670Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : Starting SimpleCrmLiteApplication v0.0.1-SNAPSHOT using Java 21.0.12.1 with PID 1 (/app/app.jar started by root in /app)
simple-crm-lite-app  | 2026-10-10T01:53:37.675Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : No active profile set, falling back to 1 default profile: "default"
simple-crm-lite-app  | 2026-10-10T01:53:38.627Z  INFO 1 --- [simple-crm-lite] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data JPA repositories in DEFAULT mode.
simple-crm-lite-app  | 2026-10-10T01:53:38.707Z  INFO 1 --- [simple-crm-lite] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 66 ms. Found 1 JPA repository interface.
simple-crm-lite-app  | 2026-10-10T01:53:39.496Z  INFO 1 --- [simple-crm-lite] [           main] o.s.boot.tomcat.TomcatWebServer          : Tomcat initialized with port 8080 (http)
simple-crm-lite-app  | 2026-10-10T01:53:39.527Z  INFO 1 --- [simple-crm-lite] [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
simple-crm-lite-app  | 2026-10-10T01:53:39.527Z  INFO 1 --- [simple-crm-lite] [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/11.0.24]
simple-crm-lite-app  | 2026-10-10T01:53:39.586Z  INFO 1 --- [simple-crm-lite] [           main] b.w.c.s.WebApplicationContextInitializer : Root WebApplicationContext: initialization completed in 1820 ms
simple-crm-lite-app  | 2026-10-10T01:53:39.835Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.jpa                    : HHH008540: Processing PersistenceUnitInfo [name: default]
simple-crm-lite-app  | 2026-10-10T01:53:39.888Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.core                   : HHH000001: Hibernate ORM core version 7.4.5.Final
simple-crm-lite-app  | 2026-10-10T01:53:40.541Z  INFO 1 --- [simple-crm-lite] [           main] o.s.o.j.p.SpringPersistenceUnitInfo      : No LoadTimeWeaver setup: ignoring JPA class transformer
simple-crm-lite-app  | 2026-10-10T01:53:40.602Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
simple-crm-lite-app  | 2026-10-10T01:53:40.885Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added connection org.postgresql.jdbc.PgConnection@5f2b9da8
simple-crm-lite-app  | 2026-10-10T01:53:40.889Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start completed.
simple-crm-lite-app  | 2026-10-10T01:53:40.987Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.connections.pooling    : HHH10001005: Database info:
simple-crm-lite-app  |  Database JDBC URL [jdbc:postgresql://db:5432/simplecrmlite]
simple-crm-lite-app  |  Database driver: PostgreSQL JDBC Driver
simple-crm-lite-app  |  Database dialect: PostgreSQLDialect
simple-crm-lite-app  |  Database version: 16.15
simple-crm-lite-app  |  Default catalog/schema: simplecrmlite/public
simple-crm-lite-app  |  Autocommit mode: undefined/unknown
simple-crm-lite-app  |  Isolation level: READ_COMMITTED [default READ_COMMITTED]
simple-crm-lite-app  |  JDBC fetch size: none
simple-crm-lite-app  |  Pool: DataSourceConnectionProvider
simple-crm-lite-app  |  Minimum pool size: undefined/unknown
simple-crm-lite-app  |  Maximum pool size: undefined/unknown
simple-crm-lite-app  | 2026-10-10T01:53:41.749Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.core                   : HHH000489: No JTA platform available (set 'hibernate.transaction.jta.platform' to enable JTA platform integration)
simple-crm-lite-app  | 2026-10-10T01:53:41.813Z  INFO 1 --- [simple-crm-lite] [           main] j.LocalContainerEntityManagerFactoryBean : Initialized JPA EntityManagerFactory for persistence unit 'default'
simple-crm-lite-app  | 2026-10-10T01:53:41.883Z  INFO 1 --- [simple-crm-lite] [           main] o.s.d.j.r.query.QueryEnhancerFactories   : Hibernate is in classpath; If applicable, HQL parser will be used.
simple-crm-lite-app  | 2026-10-10T01:53:42.003Z  WARN 1 --- [simple-crm-lite] [           main] JpaBaseConfiguration$JpaWebConfiguration : spring.jpa.open-in-view is enabled by default. Therefore, database queries may be performed during view rendering. Explicitly configure spring.jpa.open-in-view to disable this warning
simple-crm-lite-app  | 2026-10-10T01:53:42.468Z  INFO 1 --- [simple-crm-lite] [           main] o.s.boot.tomcat.TomcatWebServer          : Tomcat started on port 8080 (http) with context path '/'
simple-crm-lite-app  | 2026-10-10T01:53:42.500Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : Started SimpleCrmLiteApplication in 5.382 seconds (process running for 6.145)
simple-crm-lite-app  | Hibernate: select count(*) from customer c1_0
^C

shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl http://localhost:8080/customers/5
{"firstName":"Natasha","lastName":"Romanoff","email":"natasha@shield.gov","contactNo":"44455566","jobTitle":"Agent","yearOfBirth":1985,"id":5}shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose exec db psql -U postgres -d simplecrmlite \                                              docker compose exec db psql -U postgres -d simplecrmlite \
  -c "SELECT id, first_name, last_name FROM customer ORDER BY id;"
 id | first_name | last_name
----+------------+-----------
  1 | Bruce      | Wayne
  2 | Diana      | Prince
  3 | Clark      | Kent
  5 | Natasha    | Romanoff
(4 rows)

shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose logs app | grep "Sample data loaded"
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose down -v
[+] down 4/4
 ✔ Container simple-crm-lite-app        Removed                                                                        0.4s
 ✔ Container simple-crm-lite-db         Removed                                                                        0.3s
 ✔ Volume simple-crm-lite_postgres-data Removed                                                                        0.0s
 ✔ Network simple-crm-lite_default      Removed                                                                        0.2s
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker volume ls
DRIVER    VOLUME NAME
local     devops-demo-460_postgres-data
shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose up -d
docker compose logs -f app
[+] up 4/4
 ✔ Volume simple-crm-lite_postgres-data Created                                                                        0.0s
 ✔ Network simple-crm-lite_default      Created                                                                        0.0s
 ✔ Container simple-crm-lite-db         Healthy                                                                       10.9s
 ✔ Container simple-crm-lite-app        Started                                                                       11.0s
simple-crm-lite-app  |
simple-crm-lite-app  |   .   ____          _            __ _ _
simple-crm-lite-app  |  /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
simple-crm-lite-app  | ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
simple-crm-lite-app  |  \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
simple-crm-lite-app  |   '  |____| .__|_| |_|_| |_\__, | / / / /
simple-crm-lite-app  |  =========|_|==============|___/=/_/_/_/
simple-crm-lite-app  |
simple-crm-lite-app  |  :: Spring Boot ::                (v4.1.1)
simple-crm-lite-app  |
simple-crm-lite-app  | 2026-10-10T01:55:32.574Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : Starting SimpleCrmLiteApplication v0.0.1-SNAPSHOT using Java 21.0.12.1 with PID 1 (/app/app.jar started by root in /app)
simple-crm-lite-app  | 2026-10-10T01:55:32.578Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : No active profile set, falling back to 1 default profile: "default"
simple-crm-lite-app  | 2026-10-10T01:55:33.441Z  INFO 1 --- [simple-crm-lite] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data JPA repositories in DEFAULT mode.
simple-crm-lite-app  | 2026-10-10T01:55:33.508Z  INFO 1 --- [simple-crm-lite] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 53 ms. Found 1 JPA repository interface.
simple-crm-lite-app  | 2026-10-10T01:55:34.130Z  INFO 1 --- [simple-crm-lite] [           main] o.s.boot.tomcat.TomcatWebServer          : Tomcat initialized with port 8080 (http)
simple-crm-lite-app  | 2026-10-10T01:55:34.145Z  INFO 1 --- [simple-crm-lite] [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
simple-crm-lite-app  | 2026-10-10T01:55:34.145Z  INFO 1 --- [simple-crm-lite] [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/11.0.24]
simple-crm-lite-app  | 2026-10-10T01:55:34.175Z  INFO 1 --- [simple-crm-lite] [           main] b.w.c.s.WebApplicationContextInitializer : Root WebApplicationContext: initialization completed in 1506 ms
simple-crm-lite-app  | 2026-10-10T01:55:34.444Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.jpa                    : HHH008540: Processing PersistenceUnitInfo [name: default]
simple-crm-lite-app  | 2026-10-10T01:55:34.535Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.core                   : HHH000001: Hibernate ORM core version 7.4.5.Final
simple-crm-lite-app  | 2026-10-10T01:55:35.172Z  INFO 1 --- [simple-crm-lite] [           main] o.s.o.j.p.SpringPersistenceUnitInfo      : No LoadTimeWeaver setup: ignoring JPA class transformer
simple-crm-lite-app  | 2026-10-10T01:55:35.225Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
simple-crm-lite-app  | 2026-10-10T01:55:35.598Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added connection org.postgresql.jdbc.PgConnection@5f2b9da8
simple-crm-lite-app  | 2026-10-10T01:55:35.599Z  INFO 1 --- [simple-crm-lite] [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start completed.
simple-crm-lite-app  | 2026-10-10T01:55:35.683Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.connections.pooling    : HHH10001005: Database info:
simple-crm-lite-app  |  Database JDBC URL [jdbc:postgresql://db:5432/simplecrmlite]
simple-crm-lite-app  |  Database driver: PostgreSQL JDBC Driver
simple-crm-lite-app  |  Database dialect: PostgreSQLDialect
simple-crm-lite-app  |  Database version: 16.15
simple-crm-lite-app  |  Default catalog/schema: simplecrmlite/public
simple-crm-lite-app  |  Autocommit mode: undefined/unknown
simple-crm-lite-app  |  Isolation level: READ_COMMITTED [default READ_COMMITTED]
simple-crm-lite-app  |  JDBC fetch size: none
simple-crm-lite-app  |  Pool: DataSourceConnectionProvider
simple-crm-lite-app  |  Minimum pool size: undefined/unknown
simple-crm-lite-app  |  Maximum pool size: undefined/unknown
simple-crm-lite-app  | 2026-10-10T01:55:36.472Z  INFO 1 --- [simple-crm-lite] [           main] org.hibernate.orm.core                   : HHH000489: No JTA platform available (set 'hibernate.transaction.jta.platform' to enable JTA platform integration)
simple-crm-lite-app  | Hibernate: create table customer (id bigint generated by default as identity, contact_no varchar(255), email varchar(255), first_name varchar(255), job_title varchar(255), last_name varchar(255), year_of_birth integer, primary key (id))
simple-crm-lite-app  | 2026-10-10T01:55:36.542Z  INFO 1 --- [simple-crm-lite] [           main] j.LocalContainerEntityManagerFactoryBean : Initialized JPA EntityManagerFactory for persistence unit 'default'
simple-crm-lite-app  | 2026-10-10T01:55:36.634Z  INFO 1 --- [simple-crm-lite] [           main] o.s.d.j.r.query.QueryEnhancerFactories   : Hibernate is in classpath; If applicable, HQL parser will be used.
simple-crm-lite-app  | 2026-10-10T01:55:36.774Z  WARN 1 --- [simple-crm-lite] [           main] JpaBaseConfiguration$JpaWebConfiguration : spring.jpa.open-in-view is enabled by default. Therefore, database queries may be performed during view rendering. Explicitly configure spring.jpa.open-in-view to disable this warning
simple-crm-lite-app  | 2026-10-10T01:55:37.144Z  INFO 1 --- [simple-crm-lite] [           main] o.s.boot.tomcat.TomcatWebServer          : Tomcat started on port 8080 (http) with context path '/'
simple-crm-lite-app  | 2026-10-10T01:55:37.158Z  INFO 1 --- [simple-crm-lite] [           main] c.e.s.SimpleCrmLiteApplication           : Started SimpleCrmLiteApplication in 5.096 seconds (process running for 5.696)
simple-crm-lite-app  | Hibernate: select count(*) from customer c1_0
simple-crm-lite-app  | Hibernate: insert into customer (contact_no,email,first_name,job_title,last_name,year_of_birth) values (?,?,?,?,?,?)
simple-crm-lite-app  | Hibernate: insert into customer (contact_no,email,first_name,job_title,last_name,year_of_birth) values (?,?,?,?,?,?)
simple-crm-lite-app  | Hibernate: insert into customer (contact_no,email,first_name,job_title,last_name,year_of_birth) values (?,?,?,?,?,?)
simple-crm-lite-app  | ✅ Sample data loaded: 3 customers added
^C

shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ curl -i http://localhost:8080/customers/5
HTTP/1.1 404
Content-Length: 0
Date: Sat, 10 Oct 2026 01:55:48 GMT

shanli@BlackLoop:~/projects/4.8/simple-crm-lite$ docker compose logs app | grep "Sample data loaded"
simple-crm-lite-app  | ✅ Sample data loaded: 3 customers added