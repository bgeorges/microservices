#This is a workaround that we copy all shared files in each docker repo
docker build -t  "msdemo-db" ./mysql

mkdir ./eap6-base/shared
cp -r ./files/* ./eap6-base/shared/
docker build -t  eap6 ./eap6-base
rm -rf ./eap-base/shared

mkdir ./product/shared
cp -r ./files/* ./product/shared/
docker build -t "msdemo-product" ./product
rm -rf ./product/shared

mkdir ./sales/shared
cp -r ./files/* ./sales/shared/
docker build -t "msdemo-sales" ./sales
rm -rf ./sales/shared

mkdir ./billing/shared
cp -r ./files/* ./billing/shared/
docker build -t "msdemo-billing" ./billing
rm -rf ./billing/shared

mkdir ./frontend/shared
cp -r ./files/* ./frontend/shared/
docker build -t "msdemo-frontend" ./frontend
rm -rf ./frontend/shared

