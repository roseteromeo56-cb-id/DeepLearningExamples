#!/bin/bash
URL=${1:-"bert"}
PUSH=${2:-"none"}  # 'push' or 'none'

set -e

docker build \
  --network=host \
  --rm \
  --pull \
  --no-cache \
  --build-arg FROM_IMAGE_NAME="${FROM_IMAGE_NAME:-nvcr.io/nvidia/pytorch:21.11-py3}" \
  -t ${URL} \
  .

if [ "${PUSH}" == "push" ]; then
  docker push ${URL}
elif [ "${PUSH}" == "none" ]; then
  echo "Keep the built image locally."
else
  echo "Invalid \${PUSH} option: ${PUSH} !"
  exit 1
fi
