#Use image built from eap folder 
FROM eap6
ADD shared/mysql-connector-java-5.1.25.jar /mysql-connector-java-5.1.25.jar
ADD shared/billing.war /billing.war
ADD billing.sh /billing.sh
CMD ["/billing.sh"]
