FROM talentify/php-apache:base
LABEL version="0.1.0"
LABEL description="Image for CI on Flux application."

#precisa do git pra o cli da amazon poder fazer o deploy
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
    && apt-get update  \
    && apt-get install ruby-dev rubygems \
    git \
    nodejs \
    python-dev python-pip\
    ssh sshpass \
    zip --assume-yes \
    && gem update --system \
    && gem install sass --no-user-install \
    && npm install -g grunt-cli \
    && pip install awsebcli --upgrade \
    && curl -sOL https://github.com/jwilder/dockerize/releases/download/v0.6.0/dockerize-linux-amd64-v0.6.0.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.0.tar.gz \
    && rm dockerize-linux-amd64-v0.6.0.tar.gz
