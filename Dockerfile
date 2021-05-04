FROM ruby:2.6.7
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libjpeg62 imagemagick default-mysql-client
RUN mkdir /draw
WORKDIR /draw
COPY Gemfile /draw/Gemfile
COPY Gemfile.lock /draw/Gemfile.lock

RUN gem install bundler

COPY . /draw
