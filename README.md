# WeatherDataRescue

WeatherDataRescue is a framework for generating crowd sourced transcriptions of image-based documents.
It provides a system for generating templates which combined with a magnification tool guide a user through the process of transcribing an asset (an image). 

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
