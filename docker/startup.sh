#! /bin/sh

# ./docker/wait-for-services.sh
./docker/prepare-db.sh
# mkdir ./tmp/pids
rm -f tmp/pids/server.pid
bundle exec puma -C config/puma.rb
