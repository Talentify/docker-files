This repository contains all images used by the Talentify dev team to build, test and deploy applications

There are 3 main repositories:

- [talentify/php-apache](https://hub.docker.com/r/talentify/php-apache/)
    - Has 3 tags
        - base
            - Apache + PHP 7.1 + Phalcon 3.2.4 + composer
            - [Dockerfile](https://github.com/Talentify/docker-files/tree/master/docker/images/php-apache/base) 
        - dev
            - base image + Xdebug 2.6.0
            - [Dockerfile](https://github.com/Talentify/docker-files/tree/master/docker/images/php-apache/dev)
        - circle
            - Used in CircleCi to build and deploy the application
            - base image + npm + sass + AWS EB cli
            - [Dockerfile](https://github.com/Talentify/docker-files/tree/master/docker/images/php-apache/circle)


- [talentify/utils](https://hub.docker.com/r/talentify/utils/)
    - Single image repo
    - Contains nodejs + npm, ruby + sass, python2 + pip, and AWS EB cli
    - Used to transpile assets and deploy the code to ElasticBeanstalk
    - [Dockerfile](https://github.com/Talentify/docker-files/tree/master/docker/images/utils)

- [talentify/ssh-selenium-standalone-chrome](https://hub.docker.com/r/talentify/ssh-selenium-standalone-chrome/)
    - Single image repo
    - Based on [selenium/standalone-chrome](https://hub.docker.com/r/selenium/standalone-chrome/)
    - Has sshd running with root access via password `root`
    - [Dockerfile](https://github.com/Talentify/docker-files/tree/master/docker/images/ssh-selenium-standalone-chrome)
