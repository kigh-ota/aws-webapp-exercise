#!/bin/sh

set -x

ACCOUNT_ID=$(aws sts get-caller-identity --output json | jq --raw-output '.Account')
REGION="ap-northeast-1"
DOCKER_REPOSITORY="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
IMAGE_NAME="aws-webapp-exercise"
VERSION="0.0.1"

docker build -t ${DOCKER_REPOSITORY}/${IMAGE_NAME} .

aws cloudformation deploy --stack-name app-repository --template-file cloudformation/AppRepository.yaml
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${DOCKER_REPOSITORY}
docker push ${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}