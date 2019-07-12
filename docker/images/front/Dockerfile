FROM node:10-alpine
LABEL version="0.1.0"
LABEL description="TalentFlux image to run front-end."

RUN mkdir /public && chown node:node /public

WORKDIR /app/modules/frontend-v2
VOLUME /app

USER node:node

EXPOSE 8080
