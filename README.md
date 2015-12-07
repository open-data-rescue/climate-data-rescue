# ClimateDataRescue

## Contents
- [Introduction](#introduction)
- [Data Model Overview](#data-model-overview)
  - [Asset](#asset)
  - [Pagetype](#pagetype)
  - [Ledger](#ledger)
  - [Transcription](#transcription)
  - [Annotation](#annotation)
  - [Fieldgroup](#fieldgroup)
  - [Field](#field)
  - [User](#user)
  - [Album and Photo](#album-and-photo)
- [Requirements](#requirements)
- [Requirements Installation Guide](#requirements-installation-guide)
  - [Ruby](#ruby-193-p551-using-rvm)
  - [SQLite3](#sqlite3)
  - [NodeJS](#nodejs)
  - [LibJPEG](#libjpeg)
  - [ImageMagick](#imagemagick)
- [Project Setup](#set-up-project)
- [Configuration](#configuration)

## Introduction

ClimateDataRescue is a framework for generating crowd sourced transcriptions of image-based documents.
It provides a system for generating page templates which combined with a magnification tool guide a user through the process of transcribing an asset (an image). 

While this application was developed for the purpose of transcribing images of historical weather observation logs, it can be adapted for use in transcribing other kinds of documents as well

This application was built from scratch as a new rails app but modeled after Zooniverse's Scribe framework. It uses many of the same model types, while adding others. It also uses some styles from Scribe and Old Weather. The main differences between this project and Scribe are:
- This app uses Devise to handle user authentication while Scribe uses rubycas-client, rubycas-server and mongomapper.
- Because this app uses Devise, it does not require a seperate authentication server to be set up for user authentication and can run as a standalone product.
- Developers can add other modules using gems, and as long as they support Devise for authentication the user can have a single-sign-on experience across the different parts of the app. Examples include ActiveAdmin or forum modules.
- This app uses ActiveRecord with SQLite3 for its development database, with support for PostgreSQL and MySQL. Scribe uses mongo-mapper with Mongo-DB.
- This app uses rails methods in the transcriptions#new .slim view to build the transcription box and programmatically populate it with forms for each field group associated with the asset's pagetype. Scribe handles new transcription functiality entirely in a jquery plugin that the development team built.
- This app handles annotation creation using forms created using javascript/JQUERY and rails methods. I created and adapted a number of javascript functions to handle annotation data scructure and handling. Scribe handle annotations using the same custom jquery plugin they developed that I mentioned above
- This app allows for the creation, editing and deletion of instances of all its models through an admin interface, making it easy for an admin user to add new instances without any programming experience needed. Scribe creates model instances manually using a sample_weather_bootstrap.rake file.
- Using ActiveRecord makes it easy for developers to add new model types and add new fields to model tables. Developers can generate scaffolds for new model types or create new migrations to add columns to model tables from the terminal using rails g scaffold and rake g migration, respectively.

It is recommended to use a programming-centric and language-agnostic text editor like Sublime to work with the files contained in this project. By default, the plugin for .slim syntax highlighting is not installed and should be added to aid working with the model view files.

## Data Model Overview

There are a number of models in ClimateDataRescue:

- Asset: one ledger page
- Pagetype: set of Assets (pages) with the same layout, which is composed of multiple field groups
- Ledger: set of Pagetypes
- Transcription: set of annotations - one complete attempt at transcribing a page
- Annotation: one attempt to transcribe a part of the page
- Fieldgroup: group of fields
- Field: a specific input variable - e.g. maximum temperature
- User
- Album: collection of photos
- Photo: uploaded by a user

### Asset

-Assets are the objects (pages) which you wish to have the user transcribe. 
-They contain a link to the image file to be shown, a desired width to be displayed at and they belong to a Pagetype. 
-The Pagetype that an Asset belongs to defines the Fields (organized into Fieldgroups) that can be transcribed for that Asset. 
-Each Asset has many Transcriptions, which are users' attempts to transcribe the page.

#### Relationships
- has many: transcriptions
- belongs to: pagetype

#### Attributes
- integer  "height"
- integer  "width"
- integer  "display_width"
- string   "ext_ref"
- integer  "order"
- boolean  "done"
- integer  "classification_count"
- datetime "created_at",           :null => false
- datetime "updated_at",           :null => false
- integer  "pagetype_id"
- string   "upload_file_name"
- string   "upload_content_type"
- integer  "upload_file_size"
- datetime "upload_updated_at"
- string   "name"

### Pagetype

-A simple grouping class that links Assets (pages of a ledger) with the same layout (Fieldgroups). Most Ledgers have two Pagetypes, side A and side B.
-Has attributes for title (e.g. "Side A"), description, default zoom level and the associated ledger.

#### Relationships
- has many: assets, fieldgroups
- belongs to: ledger

#### Attributes
- string   "title"
- string   "description"
- float    "default_zoom"
- datetime "created_at",          :null => false
- datetime "updated_at",          :null => false
- integer  "ledger_id"

### Ledger

-A simple grouping class that links Pagetypes. This can be used to model a book (set of Assets (pages), organized by Pagetype).

#### Relationships
- has many: pagetypes

#### Attributes
- string   "title"
- string   "author"
- string   "extern_ref"
- integer  "pagetype_id"
- datetime "created_at",          :null => false
- datetime "updated_at",          :null => false

### Transcription

-A Transcription is the result of a user interacting with an Asset. It is composed of many Annotations.
-Essentially one attempt to transcribe a whole page.

#### Relationships
- has many: annotations
- belongs to: asset, user

#### Attributes
- text     "page_data"
- datetime "created_at", :null => false
- datetime "updated_at", :null => false
- integer  "user_id"
- integer  "asset_id"

### Annotation

-An Annotation belongs to a parent Transcription and has many Fieldgroups.
-Each annotation made for a Transcription can be thought of as entering one "row" of data.
-Each annotation is made for one Fieldgroup (collection of fields).
-The data attribute persists the content of the individual user entry (such as a name, position, date etc.)

#### Relationships
- belongs to: transcription, fieldgroup

#### Attributes
- text     "bounds"
- text     "data"
- datetime "created_at",       :null => false
- datetime "updated_at",       :null => false
- integer  "transcription_id"
- integer  "asset_id"
- integer  "fieldgroup_id"

### Field

-A Field belongs to an Fieldgroup. A Field has a key which is used in the Annotation data hash.
-The 'kind' defines how the transcription field is rendered in the UI (currently text/select/date are supported).

#### Relationships
- belongs to: fieldgroup

#### Attributes
- string   "name"
- string   "field_key"
- string   "kind"
- string   "initial_value"
- text     "options"
- text     "validations"
- datetime "created_at",    :null => false
- datetime "updated_at",    :null => false
- integer  "fieldgroup_id"

### Fieldgroup

-Fieldgroup belongs to Pagetype and is composed of many Fields.
-Fieldgroups represent different collections of data on a page.
-When a user wants to make an annotation, they will select a fieldgroup to use, which will then generate input fields for that section of the page.
-Each Pagetype will usually have at least two fieldgroups, one for information at the top of the page (such as the date/week, location and name of the person who made the recording), and one for the actual rows of data.
-Pagetypes with more complex layouts (e.g. ledger I page 1) will have more fieldgroups, because the fields of data on the page are grouped with more complexity.

#### Relationships
- has many: annotations, fields
- belongs to: pagetype

#### Attributes
- string   "name"
- string   "description"
- string   "help"
- boolean  "resizable"
- integer  "width"
- integer  "height"
- text     "bounds"
- float    "zoom"
- datetime "created_at",  :null => false
- datetime "updated_at",  :null => false
- integer  "pagetype_id"

### User

-The user producing the Transcriptions.

#### Relationships
- has many: transcriptions

#### Attributes
- string   "email",                  :default => "", :null => false
- string   "encrypted_password",     :default => "", :null => false
- string   "reset_password_token"
- datetime "reset_password_sent_at"
- datetime "remember_created_at"
- integer  "sign_in_count",          :default => 0,  :null => false
- datetime "current_sign_in_at"
- datetime "last_sign_in_at"
- string   "current_sign_in_ip"
- string   "last_sign_in_ip"
- datetime "created_at",                             :null => false
- datetime "updated_at",                             :null => false
- string   "name"
- string   "avatar_file_name"
- string   "avatar_content_type"
- integer  "avatar_file_size"
- datetime "avatar_updated_at"
- boolean  "admin"
- text     "about"
- integer  "contributions"
- string   "rank"
- integer  "asset_id"
- integer  "transcription_id"

### Album and Photo

-Albums are a collection of photos with metadata. Photos contain an image upload and metadata such as filename.
-These models are unused for the main part of the application but are included for future use. 
-They could be used to create galleries of photos that relate to the project such as historical photos taken by scientists at weather observatory stations.

#### Album Attributes
- string   "name"
- datetime "created_at", :null => false
- datetime "updated_at", :null => false

#### Photo Attributes
- integer  "album_id"
- string   "name"
- datetime "created_at",          :null => false
- datetime "updated_at",          :null => false
- string   "upload_file_name"
- string   "upload_content_type"
- integer  "upload_file_size"
- datetime "upload_updated_at"

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

## Configuration
### Database
The database configuration file can be found in "<rails_app_directory>\config\database.yml". You must specify the rails adpater for the database you are using. SQLite3 is the default and is simple to set up. No authentication needs to be set. You should not use SQLite3 for your production database. 

- [New SQLite3 Database Setup Guide](http://www.xyzpub.com/en/ruby-on-rails/3.2/seed_rb.html)

This app comes with an existing SQLite3 database so you can get started right away, but if it is not present or you would like to start from scratch, delete the existing databases and populate a new one from schema.rb and seeds.rb using: 
```
rake db:setup
rake db:schema:load
rake db:seed
```

If an administrator user was defined in the seeds.db file, use the login information identified in the seeds file to login to the app as an administrator. If you would like to set a personalized admin user, create a new user from the login form and then logout. Log back in as the predefined admin user and edit the new user's attributes to set it as admin. You may delete the predefined admin user once you create another.

*Note!*  For a new database, you may have to create a new user from the web signup form and use the rails console to give it admin privileges. 
- To set a new user's admin privileges from the rails console, first navigate to the project root in terminal and run `rails c`
- Next, type `u = User.find(1)` and press enter. Type `u` and press enter to confirm that this user has the correct attributes that you entered into the user creation form.
- Next, type `u.admin = true` into the console and press enter.
- If the operation was sucessful, typing `u` into the console and pressing enter should show that the :admin attribute was sucessfully set to true.
- If you correctly set the attribute, type `u.save` into the console and press enter to commit the changes to the database. If you don't save, the changes will not persist.

To migrate an existing SQLite3 database to PostgreSQL use [this guide](http://railscasts.com/episodes/342-migrating-to-postgresql).
