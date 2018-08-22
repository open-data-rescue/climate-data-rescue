#!/bin/bash

if [ ! -d "`pwd`/public/system" ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
  echo "`pwd`/public/system does not exist...creating"
  mkdir "`pwd`/public/system"
fi

if [ ! -d "`pwd`/public/system/field_options" ]; then
  echo "`pwd`/public/system/field_options does not exist...unzipping images"
  unzip "`pwd`/docker/init-data/draw-imgs.zip" -d "`pwd`/public/system"
fi