FROM index.docker.io/library/maven:3.6-jdk-8-alpine as builder
MAINTAINER  zhouyu muyu.zhouyu@gmail.com
COPY src/ web/src
COPY .mvn/ web/.mvn
COPY pom.xml web/
WORKDIR /web
RUN mvn clean package -Dmaven.test.skip=true

FROM daocloud.io/library/java:8u111-jre-alpine
RUN mkdir web
COPY --from=builder web/target/*.jar web/
WORKDIR /web
ENTRYPOINT ["java","-jar","./eureka-1.0.0.jar"]
