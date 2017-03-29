#!/bin/sh

NGINX_PORT=80

if [ $1 ]; then
    NGINX_PORT=$1
fi

PROJECT_NAME=`basename "$PWD"`

replace "tao.docker" "$PROJECT_NAME.docker" -- nginx.conf
replace "tao" "$PROJECT_NAME" -- nginx-proxy.conf
replace "NGINX_PORT=80" "NGINX_PORT=$NGINX_PORT" -- .env
replace "PROJECT_NAME=tao" "PROJECT_NAME=$PROJECT_NAME" -- .env