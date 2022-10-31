FROM openjdk:8-jre-alpine

RUN mkdir /app

WORKDIR /app

COPY app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]