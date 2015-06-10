#Use image built from eap folder 
FROM eap6
ADD shared/mysql-connector-java-5.1.25.jar /mysql-connector-java-5.1.25.jar
ADD shared/sales.war /sales.war
ADD sales.sh /sales.sh
CMD ["/sales.sh"]
