#!/usr/bin/bash


cd /opt/chicago/app/planorama

# TODO
eval $(docker run rlister/ecr-login:latest)
/usr/bin/docker-compose pull && /usr/bin/docker-compose down && /usr/bin/docker-compose up -d
