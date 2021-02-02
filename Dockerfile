FROM tomcat:fix1

LABEL maintainer=”vbkr1598@gmail.com”

ADD target/spring-mvc-example.war /usr/local/tomcat/webapps/spring-mvc-example.war

EXPOSE 8080

#CMD [“catalina.sh”, “run”]