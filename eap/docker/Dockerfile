#Use latest 
FROM jboss/base-jdk:8

ADD ../files/jboss-eap-6.4.0.zip /tmp/
RUN unzip /tmp/jboss-eap-6.4.0.zip -d /opt/jboss

# Set EAP_HOME environment variable
ENV EAP_HOME /opt/jboss/jboss-eap-6.4

# expose the ports for application, admin, etc..
EXPOSE 8080

# Add an admin user
RUN ${EAP_HOME}/bin/add-user.sh admin JBugAdm1n --silent

# Enable binding to all network interfaces and debugging inside the EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> ${EAP_HOME}/bin/standalone.conf


CMD ["/opt/jboss/jboss-eap-6.4/bin/standalone.sh"]
