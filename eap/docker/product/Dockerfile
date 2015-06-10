#Use image built from eap folder 
FROM eap6
ADD shared/mysql-connector-java-5.1.25.jar /mysql-connector-java-5.1.25.jar
ADD shared/product.war /product.war
ADD product.sh /product.sh
ENTRYPOINT ["/product.sh"]
