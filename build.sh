#!/usr/bin/env bash
set -ex

HUB_USERNAME=talentify
IMAGE_NAME="${HUB_USERNAME}/php-apache"
BUILD_DIR='./docker/images/php-apache'

build_app() {
    docker build --target base --tag ${IMAGE_NAME}:latest ${BUILD_DIR}
    docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:base

    docker build --target development --tag ${IMAGE_NAME}:dev ${BUILD_DIR}

    docker build --tag ${HUB_USERNAME}/utils:latest ./docker/images/utils
}

push_app() {
    docker push ${IMAGE_NAME}:latest

    docker push ${IMAGE_NAME}:dev

    docker push ${HUB_USERNAME}/utils:latest
}

build_ci() {
    docker build --target ci --tag ${IMAGE_NAME}:ci ${BUILD_DIR}
    docker tag ${IMAGE_NAME}:ci ${IMAGE_NAME}:circle

    docker build --tag ${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest ./docker/images/ssh-selenium-standalone-chrome
}

push_ci() {
    docker push ${IMAGE_NAME}:ci
    docker push ${IMAGE_NAME}:circle

    docker push ${HUB_USERNAME}/ssh-selenium-standalone-chrome:latest
}

build_app
build_ci
