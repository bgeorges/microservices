#Use image built from eap folder 
FROM eap6
ADD shared/presentation.war ${JBOSS_HOME}/standalone/deployments/presentation.war
ADD frontend.sh /frontend.sh
EXPOSE 7600 57600
CMD ["/frontend.sh"]
