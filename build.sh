#!/usr/bin/env bash
set -e

HUB_USERNAME=talentify
IMAGE_NAME="${HUB_USERNAME}/flux"
IMAGES_DIR='./docker/images'
DOCKER_TAG=${DOCKER_TAG:-}

scream() {
    echo
    echo
    echo "$@"
    echo
    echo
}

get_last_repo_tag() {
    # Get last annotated tag
    # https://stackoverflow.com/questions/1404796/how-to-get-the-latest-tag-name-in-current-branch-in-git
    # redirect stderr in order to avoid warnings
    echo $(git describe --tags $(git rev-list --tags --max-count=1) 2>/dev/null)
}

build_app() {
    docker build --tag ${IMAGE_NAME}:base "${IMAGES_DIR}/flux/base"
    docker tag ${IMAGE_NAME}:base ${IMAGE_NAME}:base-$DOCKER_TAG

    docker build --tag ${IMAGE_NAME}:dev "${IMAGES_DIR}/flux/dev"
    docker tag ${IMAGE_NAME}:dev ${IMAGE_NAME}:dev-$DOCKER_TAG

    docker build --tag ${HUB_USERNAME}/utils:latest ./docker/images/utils
    docker tag ${HUB_USERNAME}/utils:latest ${HUB_USERNAME}/utils:$DOCKER_TAG
    docker tag ${HUB_USERNAME}/utils:latest ${HUB_USERNAME}/utils:$(get_tag)

    docker build --tag ${HUB_USERNAME}/front:latest ./docker/images/front
    docker tag ${HUB_USERNAME}/front:latest ${HUB_USERNAME}/front:$(get_tag)
}

push_app() {
    docker push "${IMAGE_NAME}:base"
    docker push "${IMAGE_NAME}:base-$DOCKER_TAG"

    docker push "${IMAGE_NAME}:dev"
    docker push "${IMAGE_NAME}:dev-$DOCKER_TAG"

    docker push "${HUB_USERNAME}/utils:latest"
    docker push "${HUB_USERNAME}/utils:$DOCKER_TAG"

    docker push "${HUB_USERNAME}/front:latest"
    docker push "${HUB_USERNAME}/front:$DOCKER_TAG"
}

build_ci() {
    docker build --tag "${HUB_USERNAME}/ci:latest" "${IMAGES_DIR}/ci"
    docker tag "${HUB_USERNAME}/ci:latest" "${HUB_USERNAME}/ci:$DOCKER_TAG"

    docker build --tag "${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest" ./docker/images/ssh-selenium-standalone-chrome
    docker tag "${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest" "${HUB_USERNAME}/ssh-selenium-standalone-chrome:$DOCKER_TAG"
}

push_ci() {
    docker push "${HUB_USERNAME}/ci:latest"
    docker push "${HUB_USERNAME}/ci:$DOCKER_TAG"

    docker push "${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest"
    docker push "${HUB_USERNAME}/ssh-selenium-standalone-chrome:$DOCKER_TAG"
}

if [[ -z "$DOCKER_TAG" ]]; then
     DOCKER_TAG="$(get_last_repo_tag)"
     if [[ -z "$DOCKER_TAG" ]]; then
      echo "Unable to get last tag!" . $DOCKER_TAG
      exit 1
    fi
fi

scream "Building Flux's images with tag $DOCKER_TAG"
build_app

scream "Building CI's images with tag $DOCKER_TAG"
build_ci
