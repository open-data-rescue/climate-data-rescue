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
    - Requirements
    - Installation
    - Configuration
    - Running the application
- User Guide
- Data Model
- Attribution and Acknowlegements

## Introduction
This application seeks to aid in the digitization of paper records through the crowd-sourced transcription of scanned image files, particularly documents ill-suited for Optical Character Recognition (OCR). It specializes in recovering data stored in a highly structured format. The app fully supports multilingual localization of the user interface and the data schema organization (field labels, help texts, etc).

Administrators are given an interface with which to define their data collection schemas, and users are provided a mechanism to transcribe data contained on the page and indicate its position.

## Development Setup

The following setup has been tested on Ubuntu 18.04 LTS. Please note that the sections marked with an asterisk (\*) contain commands that are specific to this version and distribution of Linux.

#### Docker Containers

#### Environment Variables
The environment variables for the docker application are located in `docker/.env.app.conf`. The env file follows the structure defined in the [Docker Compose Environment File Guide](https://docs.docker.com/compose/env-file/)

Add app secrets:

You need two entries in the ENV for the app, `SECRET_KEY_BASE` and `SECRET_TOKEN`.

Run the following command to generate a secure token to use as the `SECRET_KEY_BASE`.

```bash
docker-compose run app bundle exec rake secret
```

Add the result from the above command to the `docker/.env.app.conf` file as the value for the `SECRET_KEY_BASE` key.

Run the following command to generate a secure token to use as the `SECRET_TOKEN`.

```bash
docker-compose run app bundle exec rake secret
```

Add the result from the above command to the `docker/.env.app.conf` file as the value for the `SECRET_TOKEN` key.

<!-- Add Recaptcha Secrets

In order to ensure that the application is secure, we use a recaptcha key to deters bots from creating accounts. You need two entries in the `docker/.env.app.conf` ENV file for the app, `RECAPTCHA_SITE_KEY` and `RECAPTCHA_SECRET_KEY`.

In order to create your Recaptcha secrets, you must go to the [Recaptcha Admin Console](https://www.google.com/recaptcha/admin/create) and register a new site. You will have to log in with your Google account.

Requirements:
- Label: Set this to whatever you want, but it should be identifiable
- Recaptcha type: reCAPTCHA v2 (invisible)
- Domains: set it to `localhost`, or whatever host name you are using for your development enviornment
- Terms of Service: You must accpet the terms of service.

After you finish creating the Recaptcha site, you will be presented with a confirmation screen containing your site key and secret key. Copy and paste each into their appropriate place in the ENV file the same way you added the secret key base and secret token above. -->

### Database Setup
Run all of the following commands to create the databases, load the application schema, and initialize with the seed data:

```bash
docker-compose run app rake db:create
docker-compose run app bin/rails db:environment:set RAILS_ENV=development
docker-compose run app bin/rails db:environment:set RAILS_ENV=test
docker-compose run app rake db:setup
```

### Starting and Stopping the application

## Attribution and Acknowlegements
This application was created in 2015 by [Robert Smith](https://www.linkedin.com/in/robert-smith-53894877/) as an undergraduate independent study project in the Department of Geography at McGill University with [Renee Sieber](http://rose.geog.mcgill.ca/) from the departments of Geography and Environmental Studies as the supervisor. It was developed in coordination with [Victoria Slonosky](https://sites.google.com/site/historicalclimatedata/Home) in her efforts to recover data from thousands of pages of historical weather observations.

This project was inspired by the [Scribe Framework](https://scribeproject.github.io/).
