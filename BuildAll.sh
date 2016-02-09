#!/bin/bash

oc new-project wordpress-php \
    --description="WordPress php" \
    --display-name="WordPress php"

oc create -f Gluster-Service.yaml
oc create -f Gluster-Endpoint.yaml
oc create -f PersistentVolumeClaim.yaml

echo "php"
oc create -f php/BuildConfig.yaml
oc create -f php/ImageStream.yaml
oc create -f php/DeploymentConfig.yaml
oc create -f php/Services.yaml
oc create -f php/Route.yaml
oc start-build php

echo "mysql"
PASSWORD=$(openssl rand 12 -base64)
echo "DB wordpress USER wordpress PASSWORD ${PASSWORD}"
oc process -f MysqlTemplate.yaml -v MYSQL_DATABASE=wordpress,VOLUME_CAPACITY=512Mi,MYSQL_USER=wordpress,MYSQL_PASSWORD=${PASSWORD} | oc create -f -
