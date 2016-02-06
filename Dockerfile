FROM anapsix/alpine-java:jre8

ARG VERSION
LABEL tombee.spring-boot-app.version="$VERSION"

ADD target/spring-boot-app-*.jar /spring-boot-app.jar

EXPOSE 8080
CMD ["java", "-jar", "/spring-boot-app.jar"]
