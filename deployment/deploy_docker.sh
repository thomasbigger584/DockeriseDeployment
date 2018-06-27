#!/usr/bin/env bash

APP_NAME=skylark

REMOTE_HOST=root@178.128.40.241
REGISTRY=docker.cloudspace.pw
REGISTRY_USERNAME=pai
REGISTRY_PASSWORD=6vvVrNfRR5LvlB2efaKx

REPOSITORY=$APP_NAME-backend
TAG=$1
LOCAL_FOLDER=src/main/docker/deployment/$TAG
DEPLOY_FOLDER=/root/deployment/.

scp -i ~/.ssh/config -prq $LOCAL_FOLDER $REMOTE_HOST:$DEPLOY_FOLDER
ssh -tt -i ~/.ssh/config $REMOTE_HOST "docker-compose -f $DEPLOY_FOLDER/$TAG/app.yml down --remove-orphans && " \
                                      "docker login -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD https://$REGISTRY/ && " \
                                      "docker pull $REGISTRY/$REPOSITORY:$TAG && " \
                                      "docker-compose -f $DEPLOY_FOLDER/$TAG/mysql.yml up -d && " \
                                      "sleep 10 && " \
                                      "docker-compose -f $DEPLOY_FOLDER/$TAG/mysql.yml down && " \
                                      "docker-compose -f $DEPLOY_FOLDER/$TAG/app.yml up -d"
