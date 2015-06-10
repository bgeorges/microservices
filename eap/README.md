# Microservices 
MSA Demos using EAP

##Pre-requisite
1. You need to download JBoss EAP (Enterprise Application Platform, our Java EE6 certified App Server). If you don't have an account you will need to register to https://community.jboss.org/register.jspa, then grab the zip file [jboss-eap-6.4.0.zip] not the jar installer.
2. Clone this repo:<pre><code>git clone https://github.com/bgeorges/microservices.git</pre></code>
##Run the Demo
1. Place the previously downloaded jboss-eap-6.4.0.zip in the files directory <pre><code>cp $your_downlaod_dir eap/files</pre></code>
2. Go to the Docker directory<pre><code>cd eap/docker</pre></code>
3. run: <pre><code>build.sh</pre></code>
4. run: <pre><code>start_all_docker.sh</pre></code>

## Architecture Overview

![Architecture Overview](images/demo_architecture.png)


## Detailed Delpoyment  

![Delpoyment Diagram](images/deployment-diagram.png)

