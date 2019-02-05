FROM talentify/php-apache:latest
LABEL version="0.1.1"
LABEL description="Image for CI on Flux application."

RUN apt-get update \
    && apt-get install --assume-yes gnupg \
    && curl -sL https://deb.nodesource.com/setup_9.x | bash -

#precisa do git pra o cli da amazon poder fazer o deploy
RUN apt-get install ruby-dev rubygems \
    git \
    nodejs \
    python-dev python-pip\
    ssh sshpass \
    zip --assume-yes \
    && gem update --system \
    && gem install sass --no-user-install \
    && npm install -g grunt-cli \
    && pip install awsebcli --upgrade \
    && curl -sOL https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz \
    && rm dockerize-linux-amd64-v0.6.1.tar.gz
