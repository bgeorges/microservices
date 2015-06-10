#Use latest 
FROM jboss/base-jdk:8

ADD shared/jboss-eap-6.4.0.zip /tmp/
RUN unzip /tmp/jboss-eap-6.4.0.zip -d /opt/jboss

# Set JBOSS_HOME environment variable
ENV JBOSS_HOME /opt/jboss/jboss-eap-6.4

# expose the ports for application, admin, etc..
EXPOSE 8080

# Add an admin user
RUN ${JBOSS_HOME}/bin/add-user.sh admin Wildfly@Adm1n --silent

# Enable binding to all network interfaces and debugging inside the EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> ${JBOSS_HOME}/bin/standalone.conf
CMD ["${JBOSS_HOME}/bin/standalone.sh"]
