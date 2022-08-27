#!/bin/bash

source "`pwd`/docker/init-images.sh"

if [ ! -d "`pwd`/log" ]; then
  echo "`pwd`/log does not exist...creating"
  mkdir "`pwd`/log"
fi

if [ ! -d "`pwd`/tmp" ]; then
  echo "`pwd`/tmp does not exist...creating"
  mkdir "`pwd`/tmp"
fi

#
# Create volumes (only does so if they do not already exist)
#
docker volume create --name=draw-db-data
docker volume create --name=draw-redis-data
docker volume create --name=draw-node_modules
docker volume create --name=draw-node_modules_sidekiq
