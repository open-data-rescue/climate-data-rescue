# DRAW - Data Rescue: Archives and Weather

[![Build Status][BS img]][Build Status]
[![Dependency Status][DS img]][Dependency Status]
[![Code Climate][CC img]][Code Climate]
[![Coverage Status][CS img]][Coverage Status]

[Build Status]: https://travis-ci.org/rsmithlal/ClimateDataRescue
[travis pull requests]: https://travis-ci.org/rsmithlal/ClimateDataRescue/pull_requests
[Dependency Status]: https://gemnasium.com/rsmithlal/ClimateDataRescue
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
- Production Setup
    - Requirements
    - Installation
    - Configuration
    - Running the application
    - Deploying changes
- User Guide
- Data Model
- Attribution and Acknowlegements

## Introduction
This application seeks to aid in the digitization of paper records through the crowd-sourced transcription of scanned image files, particularly documents ill-suided for Optical Character Recognition (OCR). It specializes in recovering data stored in a highly structured format. The app fully supports multilingual localization of the user interface and the data schema organization (field labels, help texts, etc).

Administrators are given an interface with which to define their data collection schemas, and users are provided a mechanism to transcribe data contained on the page and indicate its position. 

## Development Setup

### Software Requirements
- Operating System: Linux / MacOS
- Ruby (2.3.0) (Recommended to install using RVM)
- Ruby Bundler gem
- MySql
- libjpeg62, libjpeg62-dev
- ImageMagick

### Project Installation
#### Installing required software
##### ruby-2.3.0, using RVM
[RVM Installation Guide](http://www.webupd8.org/2014/11/how-to-install-rvm-ruby-version-manager.html) or follow instructions below.
If RVM is not currently installed, from the terminal, add the repository for RVM: 
```
sudo apt-add-repository ppa:rael-gc/rvm
```
Update package references and install:
```
sudo apt-get update
sudo apt-get install rvm
```
Install ruby and create new default gemset
```
rvm install ruby-2.3.0
rvm use 2.3.0@datarescue --create --default
```
Install bundler gem. Bundler is used to manage a Rails project's dependencies.
```
gem install bundler
```
##### MySql Server, Client
MySql is a free database server that is scalable and secure. Install from terminal:
```
sudo apt-get install mysql-server mysql-client libmysqlclient-dev
```
During installation, the script will ask you to set a password for the `root` user. This is the main administrative user for your database server. It's not essential to be secure with this password in the development environment because it will only be working locally, but for a production setup you must set a secure password and follow additional steps that will be detailed in the production version of this setup guide.

Next, we need to tell MySql to set up its database structure. We can do this by typing:
```
sudo mysql_install_db
```
##### LibJPEG
Required library for working with images. Install from terminal:
```
sudo apt-get install libjpeg62, libjpeg62-dev
```
##### ImageMagick
ImageMagick is an image processor and is required for the app to be able to transform the image files uploaded for each ledger page.

Install from terminal:
```
sudo apt-get install imagemagick
```

#### Installing project gems
Navigate to this project's directory in the terminal. Run `bundle install` to install project dependencies listed in the `Gemfile.lock` file.

### Configuration
#### Environment Variables
The environment configuration file can be found in `application.rb`. A sample `application.yml` file can be found in `<rails_app_directory>\config\application.sample.yml`. Once you enter in all the required values, you can rename it to `application.yml`.

Requried values:

#### Database
A sample database configuration file can be found in `<rails_app_directory>\config\database.sample.yml`. Once you finish entering the required info, you must rename it to `database.yml`. You must specify the rails adapter for the database you are using. MySql is the default and is straightforward to set up.

An administrator user was defined in the seeds.db file. Use the login information identified in the seeds file to login to the app as an administrator. If you would like to set a personalized admin user, either modify the information in the `<rails_app_directory>\db\seeds.rb` file, or modify the user's info from the command line or application after the database has been seeded.

Once you are ready to initialize the database with the app's structure and seed data, enter the following command from the app directory.

```
rake db:setup
```

### Running the application
Once the required software is installed and the settings have been configured, you are now ready to start the application. Simply navigate to the project directory and run the following command:
```
rails s
```
The command will start up a rails server in that terminal instance on port `3000` by default. You can pass it various options to configure the server if required. See Rails documentation for more details.

Your application is now running! You can view it by navigating to `localhost:3000` in your browser.

You should be able to log into the application as the admin user with the information defined in the `seeds.rb` file.

For more information on the `rails` command please visit the guide by [Team Treehouse] (http://blog.teamtreehouse.com/introduction-rails-command)

## Production Setup

### Software Requirements
- Operating System: Linux / MacOS
- Ruby (2.3.0) (Recommended to install using RVM)
- Ruby Bundler gem
- MySql
- libjpeg62, libjpeg62-dev
- ImageMagick

### Project Installation
#### Installing required software
##### ruby-2.3.0, using RVM
[RVM Installation Guide](http://www.webupd8.org/2014/11/how-to-install-rvm-ruby-version-manager.html) or follow instructions below.
If RVM is not currently installed, from the terminal, add the repository for RVM: 
```
sudo apt-add-repository ppa:rael-gc/rvm
```
Update package references and install:
```
sudo apt-get update
sudo apt-get install rvm
```
Install ruby and create new default gemset
```
rvm install ruby-2.3.0
rvm use 2.3.0@datarescue --create --default
```
Install bundler gem. Bundler is used to manage a Rails project's dependencies.
```
gem install bundler
```
##### MySql Server, Client
MySql is a free database server that is scalable and secure. Install from terminal:
```
sudo apt-get install mysql-server mysql-client libmysqlclient-dev
```
During installation, the script will ask you to set a password for the `root` user. This is the main administrative user for your database server. 

Next, we need to tell MySql to set up its database structure. We can do this by typing:
```
sudo mysql_install_db
```
After that completes, we need to begin to secure our production database system. This interactive script will guide you through the steps required:
```
sudo mysql_secure_installation
```
The script will ask you to set a password for the root user, and ask you questions to determine which security rules to add and action to take. Normally you can just press enter at each step to accept the default values to the questions. The script will remove sample users and databases, disable remote logins with the root user, and load the new security rules.

MySql Setup guide adapted from [DigitalOcean] (https://www.digitalocean.com/community/tutorials/how-to-use-mysql-with-your-ruby-on-rails-application-on-ubuntu-14-04)
##### LibJPEG
Required library for working with images. Install from terminal:
```
sudo apt-get install libjpeg62, libjpeg62-dev
```
##### ImageMagick
ImageMagick is an image processor and is required for the app to be able to transform the image files uploaded for each ledger page.

Install from terminal:
```
sudo apt-get install imagemagick
```
### Production setup guide to be continued


## User Guide
Forthcoming.

## Data Model
Forthcoming.

## Attribution and Acknowlegements
This project was created in 2015 as my final independent study project in Geography at McGill University with [Renee Sieber] (http://rose.geog.mcgill.ca/) from the departments of Geography and Environmental Studies as my supervisor. It was developed in coordination with [Victoria Slonosky] (https://sites.google.com/site/historicalclimatedata/Home) in her efforts to recover data from thousands of pages of historical weather observations.

This project was inspired by the [Scribe Framework] (https://scribeproject.github.io/).
