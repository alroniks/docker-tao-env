#!/bin/sh

NGINX_PORT=80

if [ $1 ]; then
    NGINX_PORT=$1
fi

PROJECT_NAME=`basename "$PWD"`

# Using @ instead of / because $PWD contains /'s
sed -i "s@PROJECT_ROOT_VALUE@$PWD@g" nginx-proxy.conf
sed -i "s/PROJECT_NAME_VALUE/$PROJECT_NAME/g" nginx-proxy.conf
sed -i "s/PROJECT_NAME_VALUE/$PROJECT_NAME/g" nginx.conf
sed -i "s/NGINX_PORT=80/NGINX_PORT=$NGINX_PORT/g" .env
sed -i "s/PROJECT_NAME_VALUE/$PROJECT_NAME/g" .env
