#!/bin/bash
echo "Stop all msdemo container if exists..."
docker ps --all | grep "msdemo-*" | cut -c -12 | xargs docker stop
docker ps --all | grep "msdemo-*" | cut -c -12 | xargs docker rm

echo "Start product mysql database..."
docker run -d --name="msdemo-productdb" msdemo-db
export PRODUCT_DB_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-productdb)
echo "product mysql database  is started on ${PRODUCT_DB_ADDRESS}"

echo "Start sales mysql database..."
docker run -d --name="msdemo-salesdb" msdemo-db
export SALES_DB_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-salesdb)
echo "sales mysql database  is started on ${SALES_DB_ADDRESS}"


 
echo "Start product httpd balancer..."
docker run -d --name="msdemo-productbalancer" msdemo-httpd
export PRODUCT_BALANCER_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-productbalancer)
echo "Product load balancer is started on ${PRODUCT_BALANCER_ADDRESS}"


echo "Start httpd balancer for sales, billing, frontend..."
docker run -d --name="msdemo-balancer" msdemo-httpd
export BALANCER_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-balancer)
echo "Load balancer for sales, billing, frontend is started on ${BALANCER_ADDRESS}"


echo "Start frontend httpd balancer..."
docker run -d -p 80:80 --name="msdemo-frontendbalancer" msdemo-httpd
export FRONTEND_BALANCER_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-frontendbalancer)
echo "Frontend load balancer is started on ${FRONTEND_BALANCER_ADDRESS}"



echo "Start 2 Product Containers..."
docker run -d --name="msdemo-product1" --add-host=product-db:${PRODUCT_DB_ADDRESS} --add-host=balancer:${PRODUCT_BALANCER_ADDRESS} msdemo-product
docker run -d --name="msdemo-product2" --add-host=product-db:${PRODUCT_DB_ADDRESS} --add-host=balancer:${PRODUCT_BALANCER_ADDRESS} msdemo-product




echo "Start 2 Billing Containers..."
docker run -d --name="msdemo-billing1" --add-host="balancer:${BALANCER_ADDRESS}" msdemo-billing
docker run -d --name="msdemo-billing2" --add-host="balancer:${BALANCER_ADDRESS}" msdemo-billing


echo "Start 2 Sales Containers..."
docker run -d --name="msdemo-sales1" --add-host=sales-db:${SALES_DB_ADDRESS} --add-host=balancer:${BALANCER_ADDRESS} msdemo-sales
docker run -d --name="msdemo-sales2" --add-host=sales-db:${SALES_DB_ADDRESS} --add-host=balancer:${BALANCER_ADDRESS} msdemo-sales

echo "Start 2 Frontend Containers..."
export LASTIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-sales2)
export lastPart=$(echo ${LASTIP} | cut -d"." -f4)
export firstPart=$(echo ${LASTIP} | cut -d"." -f1-3)
export frontend1=$(echo $firstPart"."$(($lastPart+1)))
export frontend2=$(echo $firstPart"."$(($lastPart+2)))
#export frontend3=$(echo $firstPart"."$(($lastPart+3)))

docker run -d --name="msdemo-frontend1" -e NODE_NAME=frontend1 --add-host=frontend1:${frontend1} --add-host=frontend2:${frontend2} --add-host=sales-service:${BALANCER_ADDRESS} --add-host=product-service:${PRODUCT_BALANCER_ADDRESS} --add-host=billing-service:${BALANCER_ADDRESS} --add-host=balancer:${FRONTEND_BALANCER_ADDRESS} msdemo-frontend

docker run -d --name="msdemo-frontend2" -e NODE_NAME=frontend2 --add-host=frontend1:${frontend1} --add-host=frontend2:${frontend2} --add-host=sales-service:${BALANCER_ADDRESS} --add-host=product-service:${PRODUCT_BALANCER_ADDRESS} --add-host=billing-service:${BALANCER_ADDRESS} --add-host=balancer:${FRONTEND_BALANCER_ADDRESS} msdemo-frontend


export BILLING_ADDRESS_A=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-billing1)
echo "Billing1 is started on ${BILLING_ADDRESS_A}"
export BILLING_ADDRESS_B=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-billing2)
echo "Billing2 is started on ${BILLING_ADDRESS_B}"

export PRODUCT_ADDRESS_A=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-product1)
echo "Product1 is started on ${PRODUCT_ADDRESS_A}"
export PRODUCT_ADDRESS_B=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-product2)
echo "Product2 is started on ${PRODUCT_ADDRESS_B}"


export SALES_ADDRESS_A=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-sales1)
echo "Sales1 is started on ${SALES_ADDRESS_A}"
export SALES_ADDRESS_B=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-sales2)
echo "Sales2 is started on ${SALES_ADDRESS_B}"

export FRONTEND_ADDRESS_A=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-frontend1)
echo "Frontend1 is started on ${FRONTEND_ADDRESS_A}..."  
export FRONTEND_ADDRESS_B=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' msdemo-frontend2)
echo "Frontend2 is started on ${FRONTEND_ADDRESS_B}..." 

echo "--------------------------------------SUMMARY------------------------------------------------"
echo "                                                                                             "
echo "                               FRENTEND_BALANCER:${FRONTEND_BALANCER_ADDRESS}:80             "
echo "                                                 |                                   	   "
echo "  _______________________________________________|________________________________________   "
echo "  |                                                                                      |   "
echo "  FRONTEND1:${FRONTEND_ADDRESS_A}:8080                   FRONTEND2:${FRONTEND_ADDRESS_B}:8080"
echo "  |                                                                                      |   "
echo "  |______________________________________________________________________________________|   "
echo "             |                                                            |   "
echo "  PRODUCT_BALANCER:${PRODUCT_BALANCER_ADDRESS}:80    SALES_BILLING_LOAD_BALANCER:${BALANCER_ADDRESS}:80"
echo "                                                                                             "
echo "                                                                                             "
echo "                                                                                             "
echo "                                                                                             "


echo "                               PRODUCT_BALANCER:${PRODUCT_BALANCER_ADDRESS}:80             "
echo "                                                 |                                   	   "
echo "  _______________________________________________|________________________________________   "
echo "  |                                                                                      |   "
echo "  PRODUCT1:${PRODUCT_ADDRESS_A}:8080                   PRODUCT2:${PRODUCT_ADDRESS_B}:8080"
echo "              |                                                          |                 "
echo "              |__________________________________________________________|   "
echo "                                             |                                              "
echo "                             PRODUCT_MYSQL_DB:${PRODUCT_DB_ADDRESS}:3306       "
echo "                                                                                             "
echo "                                                                                             "
echo "                                                                                             "
echo "                                                                                             "

          


echo "                       	    SALES_BILLING_LOAD_BALANCER:${BALANCER_ADDRESS}:80                          "
echo "                                                 |                                           "
echo "  _______________________________________________|________________________________________   "
echo "  |                                              |                                       |   "
echo "  |-BILLING1:${BILLING_ADDRESS_A}:8080   SALES1:${SALES_ADDRESS_A}:8080 SALES2:${SALES_ADDRESS_B}:8080"
echo "  |_BILLING2:${BILLING_ADDRESS_B}:8080           |                                       |" 
echo "                                                 |_______________________________________|"                                                                         
echo "                                                                    |                     "
echo "                                                        SALES_MYSQL_DB:${SALES_DB_ADDRESS}:3306       "
echo "---------------------------------------------------------------------------------------------"
echo ""
echo ""

echo "Please visit http://${FRONTEND_BALANCER_ADDRESS}/presentation or http://localhost/presentation to start this demo..."
echo "Access http://${FRONTEND_BALANCER_ADDRESS}:6666/mcm to look at nodes status in this cluster"

if [ -f "./address.sh" ]
then 
   rm -f address.sh
fi 
echo "export FRONTEND_BALANCER_ADDRESS=${FRONTEND_BALANCER_ADDRESS}" >> address.sh
echo "export PRODUCT_BALANCER_ADDRESS=${PRODUCT_BALANCER_ADDRESS}" >> address.sh
echo "export BALANCER_ADDRESS=${BALANCER_ADDRESS}" >> address.sh
echo "export FRONTEND_ADDRESS_A=${FRONTEND_ADDRESS_A}" >> address.sh
echo "export FRONTEND_ADDRESS_B=${FRONTEND_ADDRESS_B}" >> address.sh
echo "export PRODUCT_ADDRESS_A=${PRODUCT_ADDRESS_A}" >> address.sh
echo "export PRODUCT_ADDRESS_B=${PRODUCT_ADDRESS_B}" >> address.sh
echo "export BILLING_ADDRESS_A=${BILLING_ADDRESS_A}" >> address.sh
echo "export BILLING_ADDRESS_B=${BILLING_ADDRESS_B}" >> address.sh
echo "export SALES_ADDRESS_A=${SALES_ADDRESS_A}" >> address.sh
echo "export SALES_ADDRESS_B=${SALES_ADDRESS_B}" >> address.sh
chmod 755 address.sh


 




