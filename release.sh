#!/usr/bin/env bash
set -e

. build.sh

scream "Pushing Flux's images"
push_app

scream "Pushing CI's images"
push_ci
