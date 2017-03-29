#!/bin/sh

source .env

PORT=""

if [ $1 != '80' ]; then
    PORT=":$1"
fi

dbuser=$PROJECT_NAME
dbpass=$PROJECT_NAME
dbname=$PROJECT_NAME
dbhost="dbs"
adminuser="admin"
adminpass="QaSx1234!1"
taourl="http://$PROJECT_NAME.docker$PORT"
taons="http://$PROJECT_NAME.docker$PORT/tao.rdf"
taoext="taoCe"
wwwuser="www-data"
mode="debug"

if [ ! -f "tao/manifest.php" ]; then
    echo "Please run me in the root of a TAO dist"
    exit 1
fi

version=`cat tao/includes/constants.php | grep "'TAO_VERSION'" | sed -r "s/define\('TAO_VERSION',.?'(.*)+'\);/\1/g"`
logfile="config/generis/log.conf.php"

echo ""
echo "Going to install TAO ${version} with extensions $taoext"
echo ""

php tao/scripts/taoInstall.php \
    --db_user "${dbuser}" \
    --db_pass "${dbpass}" \
    --db_host "${dbhost}" \
    --db_driver pdo_mysql \
    --user_login "${adminuser}" \
    --user_pass "${adminpass}" \
    --module_url "${taourl}" \
    --module_mode "${mode}" \
    --db_name "${dbname}" \
    --module_namespace "${taons}" \
    -e "$taoext"

sleep 1

if [ ! -d "log" ]; then
    mkdir ./log
fi

cp ./log.conf.php $logfile
