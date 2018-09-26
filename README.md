# DRAW - Data Rescue: Archives and Weather

[![Build Status Travis (Github)][BS img]][Build Status]
[![pipeline status gitlab](https://gitlab.com/open-archives-data-rescue/climate-data-rescue/badges/master/pipeline.svg)](https://gitlab.com/open-archives-data-rescue/climate-data-rescue/commits/master)
[![Code Climate][CC img]][Code Climate]
[![Coverage Status Coveralls][CS img]][Coverage Status]
[![coverage report gitlab](https://gitlab.com/open-archives-data-rescue/climate-data-rescue/badges/master/coverage.svg)](https://gitlab.com/open-archives-data-rescue/climate-data-rescue/commits/master)

[Build Status]: https://travis-ci.org/rsmithlal/ClimateDataRescue
[travis pull requests]: https://travis-ci.org/rsmithlal/ClimateDataRescue/pull_requests
[Code Climate]: https://codeclimate.com/github/rsmithlal/ClimateDataRescue
[Coverage Status]: https://coveralls.io/r/rsmithlal/ClimateDataRescue

[BS img]: https://travis-ci.org/rsmithlal/ClimateDataRescue.png
[DS img]: https://gemnasium.com/rsmithlal/ClimateDataRescue.png
[CC img]: https://codeclimate.com/github/rsmithlal/ClimateDataRescue.png
[CS img]: https://coveralls.io/repos/rsmithlal/ClimateDataRescue/badge.png?branch=master

## Contents
- Introduction
- Development Setup
    - Requirements
    - Installation
    - Configuration
    - Running the application
- User Guide
- Data Model
- Attribution and Acknowlegements

## Introduction
This application seeks to aid in the digitization of paper records through the crowd-sourced transcription of scanned image files, particularly documents ill-suided for Optical Character Recognition (OCR). It specializes in recovering data stored in a highly structured format. The app fully supports multilingual localization of the user interface and the data schema organization (field labels, help texts, etc).

Administrators are given an interface with which to define their data collection schemas, and users are provided a mechanism to transcribe data contained on the page and indicate its position. 

## Development Setup

### Software Requirements
- docker
- docker-compose

### Project Installation
#### Installing required software
##### docker
##### docker-compose


### Setup

#### Docker Containers
Navigate to the project directory in the terminal. 

Ensure you are at the application folder and run the following script to extract the initial files and build the docker containers:

```
docker/build.sh
```

Start the database container (detached):

```
docker-compose up -d db
```

Wait 30s and check if the db container has finished initializing:
It will read `(healthy)` when it is finished. You may need to run the following command a couple more times until you see it read healthy.
```
docker ps
```

Create the databases, load the application schema, and initialize with the seed data:

```
docker-compose run app rake db:setup
```

Add app secrets:

You need two entries in the ENV for the app, `SECRET_KEY_BASE` and `SECRET_TOKEN`.

Run the following command twice to generate secure tokens.

```
docker-compose run app rake secret
```

Add an entry to the `docker/.env.app.conf`file for each key identified above, and set the values as the results of the above two `rake secret` commands.


Start the app container

```
docker-compose up app

```

Open another terminal and verify that the docker containers have started and that the local host's ports are mapped to the containers' ports:

```
docker ps

```

 You should be able to verify that two containers `draw-app` and `draw-db` have started, and their ports are being mapped to the host machine.

#### Environment Variables
The environment configuration file can be found in `application.rb`. A sample `application.yml` file can be found in `<rails_app_directory>\config\application-sample.yml`. Once you enter in all the required values, you can rename it to `application.yml`.


### Starting and Stopping the application
By now, the app server should already be running and accessible at `localhost:3000` in your browser.

To stop the app when running in current terminal window:
```
CTRL/CMD + C
```

To start the app:

```
docker-compose up app
```

You should be able to log into the application as the admin user with the information defined in the `seeds.rb` file.


## User Guide
Forthcoming.

## Data Model
Forthcoming.

## Attribution and Acknowlegements
This project was created in 2015 as my final independent study project in Geography at McGill University with [Renee Sieber] (http://rose.geog.mcgill.ca/) from the departments of Geography and Environmental Studies as my supervisor. It was developed in coordination with [Victoria Slonosky] (https://sites.google.com/site/historicalclimatedata/Home) in her efforts to recover data from thousands of pages of historical weather observations.

This project was inspired by the [Scribe Framework] (https://scribeproject.github.io/).
