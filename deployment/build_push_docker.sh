#!/usr/bin/env bash

APP_NAME=skylark

REGISTRY=docker.cloudspace.pw
REGISTRY_USERNAME=pai
REGISTRY_PASSWORD=6vvVrNfRR5LvlB2efaKx

REPOSITORY=$APP_NAME-backend
TAG=$1

./mvnw clean compile -Pprod package -DskipTests=true -e

docker build --build-arg JAVA_OPTS=-Dtag=$TAG \
			 --tag $REPOSITORY:$TAG \
			 --tag $REGISTRY/$REPOSITORY:$TAG target \
			 --label "owner=$BITBUCKET_REPO_OWNER" \
			 --label "repo=$BITBUCKET_REPO_SLUG" \
			 --label "commit=$BITBUCKET_COMMIT" \
			 --label "branch=$BITBUCKET_BRANCH" \
			 --label "tag=$BITBUCKET_TAG"

docker login -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD https://$REGISTRY/
docker push $REGISTRY/$REPOSITORY:$TAG
