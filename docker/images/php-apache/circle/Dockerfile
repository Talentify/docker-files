FROM talentify/php-apache
LABEL version="0.1.0"
LABEL description="Image for CI on Flux application."

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
    && apt-get update  \
    && apt-get install ruby-dev rubygems \
    nodejs \
    python-dev python-pip\
    ssh sshpass --assume-yes \
    && gem update --system \
    && gem install sass --no-user-install \
    && pip install --upgrade six \
    && pip install awsebcli
