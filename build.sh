#!/usr/bin/env bash
set -e

HUB_USERNAME=talentify
IMAGE_NAME="${HUB_USERNAME}/flux"
IMAGES_DIR='./docker/images'

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

get_tag() {
    [[ -n "$DOCKER_TAG" ]] && echo $DOCKER_TAG || echo $(get_last_repo_tag)
}

build_app() {
    docker build --tag ${IMAGE_NAME}:base "${IMAGES_DIR}/flux/base"
    docker tag ${IMAGE_NAME}:base ${IMAGE_NAME}:base-$(get_tag)

    docker build --tag ${IMAGE_NAME}:dev "${IMAGES_DIR}/flux/dev"
    docker tag ${IMAGE_NAME}:dev ${IMAGE_NAME}:dev-$(get_tag)

    docker build --tag ${HUB_USERNAME}/utils:latest ./docker/images/utils
    docker tag ${HUB_USERNAME}/utils:latest ${HUB_USERNAME}/utils:$(get_tag)

    docker build --tag ${HUB_USERNAME}/front:latest ./docker/images/front
    docker tag ${HUB_USERNAME}/front:latest ${HUB_USERNAME}/front:$(get_tag)
}

push_app() {
    docker push ${IMAGE_NAME}:base
    docker push ${IMAGE_NAME}:base-$(get_tag)

    docker push ${IMAGE_NAME}:dev
    docker push ${IMAGE_NAME}:dev-$(get_tag)

    docker push ${HUB_USERNAME}/utils:latest
    docker push ${HUB_USERNAME}/utils:$(get_tag)

    docker push ${HUB_USERNAME}/front:latest
    docker push ${HUB_USERNAME}/front:$(get_tag)
}

build_ci() {
    docker build --tag ${HUB_USERNAME}/ci:latest "${IMAGES_DIR}/ci"
    docker tag ${HUB_USERNAME}/ci:latest ${HUB_USERNAME}/ci:$(get_tag)

    docker build --tag ${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest ./docker/images/ssh-selenium-standalone-chrome
    docker tag ${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest ${HUB_USERNAME}/ssh-selenium-standalone-chrome:$(get_tag)
}

push_ci() {
    docker push ${HUB_USERNAME}/ci:latest
    docker push ${HUB_USERNAME}/ci:$(get_tag)

    docker push ${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest
    docker push ${HUB_USERNAME}/ssh-selenium-standalone-chrome:$(get_tag)
}

scream "Building Flux's images with tag $(get_tag)"
build_app

scream "Building CI's images with tag $(get_tag)"
build_ci
