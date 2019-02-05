#!/usr/bin/env bash
set -ex

# docker hub username
USERNAME=talentify

docker build -t ${USERNAME}/php-apache:latest docker/images/php-apache/base
docker tag ${USERNAME}/php-apache:latest ${USERNAME}/php-apache:base

docker build -t ${USERNAME}/php-apache:dev docker/images/php-apache/dev

docker build -t ${USERNAME}/php-apache:circle docker/images/php-apache/circle
docker build -t ${USERNAME}/ssh-selenium-standalone-chrome:latest docker/images/ssh-selenium-standalone-chrome

docker build -t ${USERNAME}/utils:latest docker/images/utils
