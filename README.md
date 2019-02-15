# Docker files


## About
This repository contains all images used by the Talentify dev team to build, test and deploy applications


## Build and release
* Use git flow in order to create a branch with the new version name **or** export the new version name like in `export DOCKER_TAG=1.2.0`
* `./build.sh`
* `./release.sh`


## Troubleshooting

#### illegal instruction
Please, build all images using an Intel CPU.

