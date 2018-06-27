#!/usr/bin/env bash

PROJECT_ROOT=/Users/thomasbigger/Desktop/projects/backend/skylark-backend

mkdir -p $PROJECT_ROOT/src/main/docker/deployment/
cp -a deployment/. $PROJECT_ROOT/src/main/docker/deployment/

cp bitbucket-pipelines.yml $PROJECT_ROOT

cp Dockerfile $PROJECT_ROOT/src/main/docker/

echo "Update the docker-compose service names for this app"