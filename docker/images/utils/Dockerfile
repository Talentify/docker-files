FROM node:10-stretch
LABEL version="0.2.0"
LABEL description="TalentFlux image to transpile assets."

RUN apt-get update  \
    && apt-get install ruby-dev rubygems --assume-yes \
    && gem update --system \
    && gem install sass --no-user-install

COPY start.sh /usr/local/bin/start.sh

WORKDIR /app

CMD ["start.sh"]
