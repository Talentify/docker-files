#!/usr/bin/env bash

echo "Started at $(date)"

while [[ ! -f package.json ]]; do
    echo "Unable to locate package.json"
    sleep 5s
done

echo "Running npm install"
npm install

echo "Starting grunt"
node_modules/grunt/bin/grunt wjs &

echo "Starting sass"
sass --sourcemap=none --watch --poll static/sass:public/css
