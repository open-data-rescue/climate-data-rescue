# ClimateDataRescue

This application was built from scratch as a new rails app but modeled after Zooniverse's Scribe framework. It uses many of the same model types, while adding others. It also uses some styles from Scribe and Old Weather. The main differences between this project and Scribe are:
- This app uses Devise to handle user authentication while Scribe uses rubycas-client, rubycas-server and mongomapper.
- Because this app uses Devise, it does not require a seperate authentication server to be set up for user authentication and can run as a standalone product.
- Developers can add other modules using gems, and as long as they support Devise for authentication the user can have a single-sign-on experience across the different parts of the app. Examples include ActiveAdmin or forum modules.
- This app uses ActiveRecord with SQLite3 for its development database, with support for PostgreSQL and MySQL. Scribe uses mongo-mapper with Mongo-DB.
- This app uses rails methods in the transcriptions#new .slim view to build the transcription box and programmatically populate it with forms for each field group associated with the asset's template. Scribe handles new transcription functiality entirely in a jquery plugin that the development team built.
- This app handles annotation creation using forms created using javascript/JQUERY and rails methods. I created and adapted a number of javascript functions to handle annotation data scructure and handling. Scribe handle annotations using the same custom jquery plugin they developed that I mentioned above
- This app allows for the creation, editing and deletion of instances of all its models through an admin interface, making it easy for an admin user to add new instances without any programming experience needed. Scribe creates model instances manually using a sample_weather_bootstrap.rake file.
- Using ActiveRecord makes it easy for developers to add new model types and add new fields to model tables. Developers can generate scaffolds for new model types or create new migrations to add columns to model tables from the terminal using rails g scaffold and rake g migration, respectively.

ClimateDataRescue is a framework for generating crowd sourced transcriptions of image-based documents.
It provides a system for generating templates which combined with a magnification tool guide a user through the process of transcribing an asset (an image). 

While this application was developed for the purpose of transcribing images of historical weather observation logs, it can be adapted for use in transcribing other kinds of documents as well

It is recommended to use a programming-centric and language-agnostic text editor like Sublime to work with the files contained in this project. By default, the plugin for .slim syntax highlighting is not installed and should be added to aid working with the model view files

## Requirements
- developed on Ubuntu: a UNIX-based OS will provide the best development experience
- ruby-1.9.3-p551: Recommended to install using RVM
- ruby bundler gem
- a database system: Uses sqlite3 for development, but recommended to use PostgreSQL or MySQL for development and production
- nodejs
- ImageMagick
- libjpeg62, libjpeg62-dev

##Requirements Installation Guide
###ruby-1.9.3-p551, using RVM
- [RVM Installation Guide](http://www.webupd8.org/2014/11/how-to-install-rvm-ruby-version-manager.html) or follow instructions below
- If RVM is not currently installed, from the terminal, add the repository for RVM: 
```
sudo apt-add-repository ppa:rael-gc/rvm
```
- Update and install:
```
sudo apt-get update
sudo apt-get install rvm
```
- install ruby
```
rvm install ruby-1.9.3-p551
rvm alias create default <ruby>
```
- install bundler gem
```
gem install bundler
```
### SQLite3
- install from terminal
```
sudo apt-get install sqlite3
```
- if you use another database system, look for a guide. There are certain things you must do to get PostgreSQL and MySQL working properly

###NodeJS
- install from terminal
```
sudo apt-get install nodejs
```
### LibJPEG
- install from terminal
```
sudo apt-get install libjpeg62, libjpeg62-dev
```
### ImageMagick
- install from terminal
```
sudo apt-get install imagemagick
```
## Set up project
- navigate to your project directory 
```
cd <your_project_directory_location>
```
- install the gems required for the project
```
bundle install
```
- run the rails server
```
rails s OR rails server
```
- Open the project in your browser. Navigate to localhost:3000
