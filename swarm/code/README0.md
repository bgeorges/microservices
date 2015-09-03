# Admin - Test all the APIs we need for the Swarm based demo

The original MSA demo uses EAP6 and docker. Here we leverage swarm to deliver both Rest, Persistance and the abkity to run each as a single unit within its own "Swarm container" - as an executable jar.
This build a runnable jar. There are 2 servlets that use JPA to display the content of table.
Check the pom.xml for the dependencies you need


## Run

As other wildfly-swarm-examples, you can run it many ways:

* mvn package && java -jar ./target/wildfly-swarm-example-jpa-servlet-swarm.jar
* mvn wildfly-swarm:run
* From your IDE, run class `org.wildfly.swarm.Swarm`

## Use

    http://localhost:8080/admin
    or
    http://localhost:8080/item
