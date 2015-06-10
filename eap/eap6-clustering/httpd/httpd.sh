#!/bin/sh
HTTPD_DIR=/opt/jboss-ews-2.0/httpd
$HTTPD_DIR/sbin/httpd -f $HTTPD_DIR/conf/cluster$1.conf -E $HTTPD_DIR/logs/httpd$1.log -k $2
