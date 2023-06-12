#!/usr/bin/env bash

YB_RELEASE=${1:-2.18.0.1-b4}
YB_VERSION=${YB_RELEASE%-*}
YB_BUILD=${YB_RELEASE//*-/}
YB_VERSION_PATCH=${YB_VERSION%.*}
YB_VERSION_MINOR=${YB_VERSION_PATCH%.*}
YB_VERSION_MAJOR=${YB_VERSION_MINOR%.*}

DOCKERHUB_REGISTRY=${DOCKERHUB_REGISTRY:-yogendra/yugabyte}
GITHUB_REGISTRY=${GITHUB_REGISTRY:-ghcr.io/yogendra/yugabyte}

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg YB_VERSION=${YB_VERSION} \
  --build-arg YB_BUILD=${YB_BUILD} \
  --build-arg YB_RELEASE=${YB_RELEASE} \
  --push \
  --progress plain \
  -t ${GITHUB_REGISTRY}:latest \
  -t ${GITHUB_REGISTRY}:${YB_VERSION_MAJOR} \
  -t ${GITHUB_REGISTRY}:${YB_VERSION_MINOR} \
  -t ${GITHUB_REGISTRY}:${YB_VERSION_PATCH} \
  -t ${GITHUB_REGISTRY}:${YB_VERSION} \
  -t ${GITHUB_REGISTRY}:${YB_RELEASE} \
  -t ${DOCKERHUB_REGISTRY}:latest \
  -t ${DOCKERHUB_REGISTRY}:${YB_VERSION_MAJOR} \
  -t ${DOCKERHUB_REGISTRY}:${YB_VERSION_MINOR} \
  -t ${DOCKERHUB_REGISTRY}:${YB_VERSION_PATCH} \
  -t ${DOCKERHUB_REGISTRY}:${YB_VERSION} \
  -t ${DOCKERHUB_REGISTRY}:${YB_RELEASE} \
  .
