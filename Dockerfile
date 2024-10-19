FROM maven:3.8.6-openjdk-8 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/spring-boot-2-hello-world-1.0.2-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]