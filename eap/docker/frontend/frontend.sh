#!/bin/bash
${JBOSS_HOME}/bin/standalone.sh -c standalone-ha.xml&
JBOSS_CONSOLE_LOG=${JBOSS_HOME}/standalone/log/server.log
STARTUP_WAIT=60
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
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=advertise,value=false)
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=sticky-session,value=true)
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=proxy-list,value="balancer:6666")
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=node-timeout,value=10)
/subsystem=modcluster/mod-cluster-config=configuration/:write-attribute(name=ping,value=2)
run-batch
exit
EOF
${JBOSS_HOME}/bin/jboss-cli.sh --connect shutdown
export IP_ADDRESS=$(ip addr | awk '/inet/ && /eth0/{sub(/\/.*$/,"",$2); print $2}')
cp /ClusterWebApp.war ${JBOSS_HOME}/standalone/deployments/
echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=${IP_ADDRESS} -Djboss.bind.address.management=${IP_ADDRESS}\"" >> ${JBOSS_HOME}/bin/standalone.conf
${JBOSS_HOME}/bin/standalone.sh -Djboss.node.name=$NODE_NAME -c standalone-ha.xml




