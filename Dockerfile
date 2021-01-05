FROM ruby:2.5.3

# Install Node and Yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev yarn nodejs libjpeg62 imagemagick graphviz mysql-client
RUN mkdir /draw
WORKDIR /draw
COPY Gemfile /draw/Gemfile
COPY Gemfile.lock /draw/Gemfile.lock

RUN gem install bundler

COPY . /draw
