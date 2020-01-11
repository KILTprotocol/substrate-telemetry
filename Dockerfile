FROM node:10-alpine

WORKDIR /app

RUN apk update && apk add --no-cache python g++ make openssh git bash
RUN export PYTHONPATH=${PYTHONPATH}:/usr/lib/python2.7

COPY ./scripts ./scripts
COPY ./packages ./packages
COPY ./package.json ./yarn.lock ./tsconfig.json ./


RUN yarn 

EXPOSE 3000

# Frontend is exposing 3000
# Backend is exposing 8080
# No need for expose, if using docker-compose & docker run -p 3000:3000
