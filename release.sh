#!/usr/bin/env bash

. build.sh

docker push ${USERNAME}/php-apache:latest
#docker push ${USERNAME}/php-apache:base

docker push ${USERNAME}/php-apache:dev

docker push ${USERNAME}/php-apache:circle
docker push ${USERNAME}/ssh-selenium-standalone-chrome:latest

docker push ${USERNAME}/utils:latest
