#!/bin/sh

set -x


ACCOUNT_ID=$(aws sts get-caller-identity --output json | jq --raw-output '.Account')
REGION="ap-northeast-1"
DOCKER_REPOSITORY="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
IMAGE_NAME="aws-webapp-exercise"
VERSION="0.0.1"

IMAGE_TAGS=$(aws ecr list-images --repository-name aws-webapp-exercise --output json | \
  jq -r '.imageIds | map("imageTag=" + .imageTag) | join(" ")')
if [ ! -z "$IMAGE_TAGS" ]; then
  aws ecr batch-delete-image --repository-name ${IMAGE_NAME} --image-ids ${IMAGE_TAGS}
fi
aws cloudformation delete-stack --stack-name app-repository