FROM openjdk:24-ea-21-jdk-slim

COPY build/libs/hello-world-api.jar /opt/hello-world-api.jar

ENV spring.profiles.active=dev
CMD ["java", "-jar", "/opt/hello-world-api.jar"]
