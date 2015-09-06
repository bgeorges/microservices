FROM java:openjdk-8-jdk

ADD shared/admin-swarm.jar /admin-swarm.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/admin-swarm.jar"]
