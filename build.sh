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

build_app() {
    docker build --tag ${IMAGE_NAME}:base "${IMAGES_DIR}/flux/base"
#    docker tag ${IMAGE_NAME}:base-latest ${IMAGE_NAME}:base

    docker build --tag ${IMAGE_NAME}:dev "${IMAGES_DIR}/flux/dev"

    docker build --tag ${HUB_USERNAME}/utils:latest ./docker/images/utils
}

push_app() {
    docker push ${IMAGE_NAME}:base

    docker push ${IMAGE_NAME}:dev

    docker push ${HUB_USERNAME}/utils:latest
}

build_ci() {
    docker build --tag ${HUB_USERNAME}/ci:latest "${IMAGES_DIR}/ci"

    docker build --tag ${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest ./docker/images/ssh-selenium-standalone-chrome
}

push_ci() {
    docker push ${HUB_USERNAME}/ci:latest

    docker push ${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest
}

scream "Building Flux's images"
build_app

scream "Building CI's images"
build_ci
