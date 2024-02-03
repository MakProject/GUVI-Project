#!/bin/bash

docker container stop webapp && docker container rm webapp

#deploying docker image using docker-compose file
docker-compose up -d
