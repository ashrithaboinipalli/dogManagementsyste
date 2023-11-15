# Use an image with Maven and Java 17 for the build stage
FROM maven:3.8.4-openjdk-17 AS build

# Copy the source code to the container
COPY . .

# Build the project using Maven
RUN mvn clean package -Pprod -DskipTests

# Use an image with Java 17 for the final runtime image
FROM openjdk:17-jdk-slim AS final

# Copy the JAR file from the build stage to the final image
COPY --from=build /target/DogsManagementSystem-0.0.1-SNAPSHOT.jar DogsManagementSystem.jar

# Specify the command to run on container start
CMD ["java", "-jar", "DogsManagementSystem.jar"]