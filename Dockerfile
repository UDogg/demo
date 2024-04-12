# Use a Maven base image to build the project
FROM maven:3.9.6-openjdk-21 as builder

# Copy the pom.xml file and source code
COPY ./pom.xml /build/pom.xml
COPY ./src /build/src

# Set the working directory
WORKDIR /build

# Build the application without running tests
RUN mvn clean package -DskipTests

# Start with a base image that has Java 21 installed
FROM openjdk:21.0.2-jdk
EXPOSE 8080

# Optionally set a maintainer name to let people know who made this Dockerfile
LABEL maintainer="choudharyu2003@gmail.com"

# Set a working directory inside the container
ADD target/demo.jar demo.jar

ENTRYPOINT ["java", "-jar", "/demo.jar"]
