# WeatherDataRescue

WeatherDataRescue is a framework for generating crowd sourced transcriptions of image-based documents
It provides a system for generating templates which combined with a magnification tool guide a user through the process of transcribing an asset (an image). 

## Requirements
- developed on Ubuntu: a UNIX-based OS will provide the best development experience
- ruby-1.9.3-p551: Recommended to install using RVM
- ruby bundler gem
- a database system: Uses sqlite3 for development, but recommended to use PostgreSQL or MySQL for development and production
- nodejs
- ImageMagick
- libjpeg62, libjpeg62-dev

#Requirements Installation Guide
##ruby-1.9.3-p551, using RVM
- If RVM is not currently installed
-- From the terminal, add the repository for RVM: http://www.webupd8.org/2014/11/how-to-install-rvm-ruby-version-manager.html
```sudo apt-add-repository ppa:rael-gc/rvm
-- Update and install:
```sudo apt-get update
```sudo apt-get install rvm