FROM ruby:2.3.7
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libjpeg62 imagemagick mysql-client
RUN mkdir /draw
WORKDIR /draw
COPY Gemfile /draw/Gemfile
COPY Gemfile.lock /draw/Gemfile.lock
RUN bundle update
COPY . /draw