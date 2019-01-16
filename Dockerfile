FROM openjdk:8-jre-alpine
WORKDIR /
ADD dropwizard.jar dropwizard.jar
ADD mysql.yml mysql.yml
EXPOSE 8080
CMD java -jar dropwizard.jar server mysql.yml
