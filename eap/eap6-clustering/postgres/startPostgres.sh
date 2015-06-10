#!/bin/sh
sudo su - postgres -c '/usr/pgsql-9.2/bin/pg_ctl -D /var/lib/pgsql/9.2/data -l /files/postgres/postgres.log start'
