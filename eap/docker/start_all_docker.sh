#!/bin/bash
echo "Stop all msdemo container if exists..."
docker ps --all | grep "msdemo-*" | cut -c -12 | xargs docker stop
docker ps --all | grep "msdemo-*" | cut -c -12 | xargs docker rm

echo "Start mysql database..."
docker run -d --name="msdemo-db" msdemo-db
export DB_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-db)
echo "mysql database  is started on ${DB_ADDRESS}"
 
echo "Start httpd balancer..."
docker run -d --name="msdemo-balancer" msdemo-httpd
export BALANCER_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-balancer)
echo "Load balancer is started on ${BALANCER_ADDRESS}"

echo "Start Billing Container..."
docker run -d --name="msdemo-billing" --add-host="balancer:${BALANCER_ADDRESS}" msdemo-billing

echo "Start Product Container..."
docker run -d --name="msdemo-product" --add-host=product-db:${DB_ADDRESS} --add-host=balancer:${BALANCER_ADDRESS} msdemo-product

echo "Start Sales Container..."
docker run -d --name="msdemo-sales" --add-host=sales-db:${DB_ADDRESS} --add-host=balancer:${BALANCER_ADDRESS} msdemo-sales

echo "Start Frontend Container..."
docker run -d -p 80:8080 --name="msdemo-frontend" --add-host=sales-service:${BALANCER_ADDRESS} --add-host=product-service:${BALANCER_ADDRESS} --add-host=billing-service:${BALANCER_ADDRESS} msdemo-frontend

export BILLING_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-billing)
echo "Billing is started on ${BILLING_ADDRESS}"
export PRODUCT_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-product)
echo "Product is started on ${PRODUCT_ADDRESS}"
export SALES_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-sales)
echo "Sales is started on ${SALES_ADDRESS}"
export FRONTEND_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-frontend)
echo "FRONTEND_ADDRESS is started on ${FRONTEND_ADDRESS}..."  

echo "--------------------------------------SUMMARY------------------------------------------------"
echo "                                                                                             "
echo "                               FRENTEND:${FRONTEND_ADDRESS}:8080                        "
echo "                                                 |                                   	   "
echo "                                                 |                                   	   "
echo "                       	     LOAD_BALANCER:${BALANCER_ADDRESS}:80                          "
echo "                                                 |                                           "
echo "  _______________________________________________|________________________________________   "
echo "  |                                              |                                       |   "
echo "  BILLING:${BILLING_ADDRESS}:8080   PRODUCT:${PRODUCT_ADDRESS}:8080      SALES:${SALES_ADDRESS}:8080"
echo "                                                 |                                       |" 
echo "                                                 |_______________________________________|"                                                                         
echo "                                                                    |                     "
echo "                                                        MYSQL_DB:${DB_ADDRESS}:3306       "
echo "---------------------------------------------------------------------------------------------"
echo ""
echo ""

echo "Please visit http://${FRONTEND_ADDRESS}:8080/presentation or http://localhost/presentation to start this demo..."
echo "Access http://${BALANCER_ADDRESS}:6666/mcm to look at nodes status in this cluster" 




