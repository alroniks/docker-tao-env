#!/bin/sh

NGINX_PORT=80

if [ $1 ]; then
    NGINX_PORT=$1
fi

PROJECT_NAME=`basename "$PWD"`

# using @ instead of / because $PWD contains /'s
sed -i "s@PROJECT_ROOT@$PWD@g" nginx-proxy.conf
sed -i "s/tao/$PROJECT_NAME/g" nginx-proxy.conf
sed -i "s/tao.docker/$PROJECT_NAME.docker/g" nginx.conf
sed -i "s/NGINX_PORT=80/NGINX_PORT=$NGINX_PORT/g" .env
sed -i "s/PROJECT_NAME=tao/PROJECT_NAME=$PROJECT_NAME/g" .env
