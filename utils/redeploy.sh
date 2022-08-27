#!/usr/bin/bash


cd /opt/climate-data-rescue/app/draw

# TODO
eval $(docker run rlister/ecr-login:latest)
/usr/bin/docker-compose pull && /usr/bin/docker-compose down && /usr/bin/docker-compose up -d
