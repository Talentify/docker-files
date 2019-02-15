# Docker files


## About
This repository contains all images used by the Talentify dev team to build, test and deploy applications


## Build and release
* Use git flow in order to create a branch with the new version name **or** export the new version name like in `export DOCKER_TAG=1.2.0`
* `./build.sh`
* `./release.sh`


## Troubleshooting

#### illegal instruction
Please, build all images using an Intel CPU

#### webdriver
If acceptance tests are frequently failing, check the webdriver/chromedriver version of the last passing version and compare with the current one. When the selenium image is started, it show a INFO log with the string "Starting ChromeDriver x.yy.zz". This information is also available on the acceptance tests messages when a driver/connector error occurs.
