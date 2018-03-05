FROM node:9-stretch
LABEL version="0.1.0"
LABEL description="TalentFlux image to transpile assets and deploy the project."

RUN apt-get update  \
    && apt-get install ruby-dev rubygems \
    python-dev python-pip --assume-yes \
    && gem update --system \
    && gem install sass --no-user-install \
    && pip install awsebcli

COPY init.sh /init.sh

WORKDIR /app

CMD ["/bin/bash", "/init.sh"]
