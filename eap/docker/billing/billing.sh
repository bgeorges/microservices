#!/bin/bash
${JBOSS_HOME}/bin/standalone.sh -c standalone-ha.xml&
JBOSS_CONSOLE_LOG=${JBOSS_HOME}/standalone/log/server.log
STARTUP_WAIT=30
count=0
until [ $count -gt $STARTUP_WAIT ]
   do
     grep 'JBAS015874:' $JBOSS_CONSOLE_LOG > /dev/null 
     if [ $? -eq 0 ] ; then
       launched=true
       break
     fi 
     sleep 5
     let count=$count+1;
   done
${JBOSS_HOME}/bin/jboss-cli.sh --connect <<EOF
batch
module add --name=org.mysql --resources=/mysql-connector-java-5.1.25.jar --dependencies=javax.api,javax.transaction.api
/subsystem=datasources/jdbc-driver=mysql:add(driver-module-name=org.mysql,driver-name=mysql,driver-class-name=com.mysql.jdbc.Driver)
deploy /billing.war
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=advertise,value=false)
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=sticky-session,value=true)
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=proxy-list,value="balancer:6666")
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=node-timeout,value=10)
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=ping,value=2)
run-batch
exit
EOF
${JBOSS_HOME}/bin/jboss-cli.sh --connect shutdown
${JBOSS_HOME}/bin/standalone.sh -c standalone-ha.xml


