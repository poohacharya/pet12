FROM openjdk:8-jdk-alpine
EXPOSE 9181
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar","--server.port=9181"]
