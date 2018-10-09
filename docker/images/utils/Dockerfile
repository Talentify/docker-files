FROM node:9-stretch
LABEL version="0.1.1"
LABEL description="TalentFlux image to transpile assets.1"

RUN apt-get update  \
    && apt-get install ruby-dev rubygems --assume-yes \
    && gem update --system \
    && gem install sass --no-user-install

COPY start.sh /usr/local/bin/start.sh

WORKDIR /app

CMD ["start.sh"]
