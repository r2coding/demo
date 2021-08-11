FROM maven:3-jdk-8-alpine AS builder
RUN mkdir -p /app/src  
COPY ./src /app/src
COPY ./pom.xml /app
WORKDIR /app
RUN mvn clean package

FROM openjdk:8-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
COPY --from=builder /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
