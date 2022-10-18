# DRAW - Data Rescue: Archives and Weather

[![Build Status Travis (Github)][BS img]][Build Status]
[![Code Climate][CC img]][Code Climate]

[Build Status]: https://travis-ci.org/rsmithlal/ClimateDataRescue
[travis pull requests]: https://travis-ci.org/rsmithlal/ClimateDataRescue/pull_requests
[Code Climate]: https://codeclimate.com/github/rsmithlal/ClimateDataRescue

[BS img]: https://travis-ci.org/rsmithlal/ClimateDataRescue.png
[CC img]: https://codeclimate.com/github/rsmithlal/ClimateDataRescue.png

## Contents
- Introduction
- Development Setup
    - Environment Variables
    - Starting and Stopping the application
- Attribution and Acknowlegements

## Introduction
This application seeks to aid in the digitization of paper records through the crowd-sourced transcription of scanned image files, particularly documents ill-suited for Optical Character Recognition (OCR). It specializes in recovering data stored in a highly structured format. The app fully supports multilingual localization of the user interface and the data schema organization (field labels, help texts, etc).

Administrators are given an interface with which to define their data collection schemas, and users are provided a mechanism to transcribe data contained on the page and indicate its position.

## Development Setup

Apart from GIT and whatever IDE/editor you prefer to use the minimum to run a dev env is docker desktop.

### Environment Variables

You will need to create a .envrc file. The minimal content should have

```
export MYSQL_ROOT_PASSWORD=yourpassword
export MYSQL_PASSWORD=yourpassword
export SIDEKIQ_REDIS_URL=redis://localhost:6379/0
export SMTP_PORT=10025
export SMTP_SERVER=127.0.0.1
export HOSTNAME=localhost
export HOSTPORT=3000
export DEVISE_SECRET=
export SECRET_KEY_BASE=
export SECRET_TOKEN=
```

For development set the MYSQL_ROOT_PASSWORD and MYSQL_PASSWORD to the same value
will be used by the docker scripts to create an instance of the database and set up the initial database.
Also by the Rails database.yml for the connection. In local dev their value is unimportant and can be used as-is.

`DEVISE_SECRET`, `SECRET_KEY_BASE`, and `SECRET_TOKEN` will need values. You can generate values for them using the following commands:

```
docker-compose -p draw-dev -f docker-compose-dev.yml run draw bundle install
docker-compose -p draw-dev -f docker-compose-dev.yml run draw bundle exec rake secret
```

### Starting and Stopping the application

The dev docker compose uses external volumes so that we can persist data between runs. These are created using the following:

```
docker volume create --name=draw-db-data
docker volume create --name=draw-redis-data
docker volume create --name=draw-node_modules
docker volume create --name=draw-node_modules_sidekiq
```

Then to start the dev docker instances use

```
docker-compose -p draw-dev -f docker-compose-dev.yml up
```

or

```
docker-compose -p draw-dev -f docker-compose-dev.yml up --build -d
```

The secound will detach the docker processes from your shell so it remains running.

You will be able to access the running server via http://localhost:3000
and a test user will available (draw-dev-admin@grr.la with password password)

## Attribution and Acknowlegements
This application was created in 2015 by [Robert Smith](https://www.linkedin.com/in/robert-smith-53894877/) as an undergraduate independent study project in the Department of Geography at McGill University with [Renee Sieber](http://rose.geog.mcgill.ca/) from the departments of Geography and Environmental Studies as the supervisor. It was developed in coordination with [Victoria Slonosky](https://sites.google.com/site/historicalclimatedata/Home) in her efforts to recover data from thousands of pages of historical weather observations.

This project was inspired by the [Scribe Framework](https://scribeproject.github.io/).
