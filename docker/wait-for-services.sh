#! /bin/sh

# Wait for MongoDB
until nc -z -v -w30 $DB_HOST $DB_PORT
do
  echo 'Waiting for MongoDB...'
  sleep 1
done
echo "MongoDB is up and running"

