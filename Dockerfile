# ============================================
# STAGE 1: BUILD
# ============================================
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copy pom.xml first (for better caching)
COPY pom.xml .

# Download dependencies (cached if pom.xml doesn't change)
RUN mvn dependency:go-offline -B

# Explanation of mvn dependency:go-offline
# This is a Maven Dependency Plugin goal. It analyzes your project's configuration file (pom.xml) and pre-downloads every library, plugin, and core dependency into the container's local .m2 repository.

# -B 
#  Tells Apache Maven to run in batch (non-interactive) mode. It stops Maven from outputting unnecessary download progress logs (like thousands of Transferring... lines) and prevents the build from hanging by automatically accepting default options instead of pausing for user input.


# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# ============================================
# STAGE 2: RUN
# ============================================
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy JAR from build stage
COPY --from=build /app/target/simple-crm-lite-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]