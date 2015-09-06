#!/bin/bash
StartMySQL ()
{
   /usr/bin/mysqld_safe > /dev/null 2>&1&
    sleep 5
    mysql -uroot < setup.sql
    echo "=> Done!"
    echo "========================================================================"
    echo "You can now connect to this MySQL Server Now"
}
StartMySQL
mysqladmin -uroot shutdown
exec mysqld_safe

