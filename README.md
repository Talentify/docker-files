# Docker files


## About
This repository contains some images used by the Talentify dev team to build, test and deploy applications.

Note that breaking changes can occur without a new major version, as this image is intended to be used only locally.

If you'd like to use Phalcon images for docker, take a look at https://github.com/Talentify/phalcon-framework-docker.


## Building and releasing
Each new image is released under a new tag like `v1.6.0`.

You can build and release a new image using the provided scripts with either a new feature branch or an environment variable.

Example using a feature branch:
```console
$ git flow release start 1.6.0
# do your stuff
$ git flow release finish 1.6.0
$ ./build.sh
$ ./release.sh
```

Example using an environment variable:
```console
$ export DOCKER_TAG=v1.2.0
$ ./build.sh
$ ./release.sh
```


## Troubleshooting

#### illegal instruction
Please, build all images using an Intel CPU

#### webdriver
If acceptance tests are frequently failing, check the webdriver/chromedriver version of the last passing version and compare with the current one. When the selenium image is started, it show a INFO log with the string "Starting ChromeDriver x.yy.zz". This information is also available on the acceptance tests messages when a driver/connector error occurs.
