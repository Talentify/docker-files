FROM talentify/php-apache
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
    && pip install awsebcli --upgrade
