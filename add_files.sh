#!/usr/bin/env bash

PROJECT_ROOT=/Users/thomasbigger/Desktop/projects/backend/rimz

mkdir -p $PROJECT_ROOT/src/main/docker/deployment/
cp -a deployment/. $PROJECT_ROOT/src/main/docker/deployment/

cp bitbucket-pipelines.yml $PROJECT_ROOT

cp Dockerfile $PROJECT_ROOT/src/main/docker/

cd $PROJECT_ROOT
git add .

echo "Update the docker-compose service names and registry details for this app"