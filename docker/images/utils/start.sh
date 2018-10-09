#!/usr/bin/env bash

echo "Started at $(date)"

while [[ ! -f package.json ]]; do
    echo "Unable to locate package.json"
    sleep 5s
done

echo "Running npm install"
npm install

echo "Starting gulp"
node_modules/gulp/bin/gulp.js watch &

echo "Starting sass"
sass --sourcemap=none --watch --poll static/sass:public/css
