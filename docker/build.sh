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

# docker-compose build
# docker-compose run app bundle
