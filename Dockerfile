FROM openjdk:17-jdk-slim

# Set environment variables for Spring Boot to connect to external MySQL
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/mydb
ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=root

# Create and set working directory (optional but cleaner)
WORKDIR /app

# Copy the JAR file to the container
COPY target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "app.jar"]
