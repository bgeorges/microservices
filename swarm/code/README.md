# Microservice Architecture - Based on Wildfly-Swarm

The original MSA demo uses EAP6 and docker. Here we leverage swarm  and run each service as a single unit in its own "Swarm container" - as an executable jar.
The good thing with swarm is that there is pretty much no code change (will confirm as I complete the port)
The changes revolve around updating the maven dependencies. That's pretty much it.


## Status
The Admin part is added as a place to test and validate all the APIs we need in the other modules.
The parent pom is ok, the pom for the other modules are WIP.
