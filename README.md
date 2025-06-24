git clone

docker-compose up --build

http://192.168.56.102:8080/products

****************************

Dockerfile


# ----------- Stage 1: Build the app using Maven -----------

FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set environment variables for DB (used by Spring Boot)
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=mydb
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/mydb
ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=root


# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies first (for caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the rest of the source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# ----------- Stage 2: Run the app using JDK -----------
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]

----

docker build -t springappimg:v1 .

 docker images

 docker run -d   --name mysql-db   -e MYSQL_ROOT_PASSWORD=root   -e MYSQL_DATABASE=mydb   -p 3306:3306   mysql:8.0

 docker network create springboot-network

 docker network connect springboot-network mysql-db

 docker images

 docker run -d   --name springboot-app   --network springboot-network   -p 8080:8080   -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql-db:3306/mydb   -e SPRING_DATASOURCE_USERNAME=root   -e SPRING_DATASOURCE_PASSWORD=root   springappimg:v1


