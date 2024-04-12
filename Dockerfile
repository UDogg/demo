# Use a Maven base image to build the project with Java 17
FROM maven:3.8.6-openjdk-17 AS builder

# Copy the pom.xml file and source code
COPY ./pom.xml /build/pom.xml
COPY ./src /build/src

# Set the working directory
WORKDIR /build

# Build the application without running tests
RUN mvn clean package -DskipTests

# Start with a base image that has Java 17 installed
FROM eclipse-temurin:17-jdk

# Expose the port the app runs on
EXPOSE 8080

# Set a maintainer name
LABEL maintainer="choudharyu2003@gmail.com"

# The application's jar file
ADD target/demo.jar demo.jar

ENTRYPOINT ["java", "-jar", "/demo.jar"]
