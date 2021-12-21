source 'https://rubygems.org'

ruby '2.6.7'

gem 'rails', '~> 5.2.6'

gem 'mysql2'

gem 'mime-types', require: 'mime/types/full'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem "ranked-model"

gem 'uglifier'

gem 'activerecord-session_store'

#bootstrap stuff
gem 'sass-rails'
#gem 'sprockets-rails'
gem 'bootstrap-sass'

# source 'https://rails-assets.org' do
#   gem 'rails-assets-tether', '>= 1.1.0'
# end

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer'

gem 'modernizr-rails'

gem "figaro"
gem 'log4r'

#for user authentication
gem 'devise'
gem 'pundit'
#to handle .slim files
gem 'slim-rails'

gem "sentry-raven"

#for forms
gem 'simple_form'
gem 'will_paginate'

#for attachments
gem 'paperclip'
gem 'aws-sdk-s3', '~> 1'

# Support for tag inputs
gem 'select2-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'jsonapi-rails'
gem 'jsonapi-rspec'

gem "jquery-fileupload-rails"

gem 'routing-filter', git: 'https://github.com/svenfuchs/routing-filter'

gem 'http_accept_language'

gem 'rails-i18n'
gem 'i18n-active_record', :require => 'i18n/active_record'
# gem 'i18n-tasks'

gem 'rails-observers'

gem 'friendly_id', '~> 5.4.2'
gem 'mobility', '~> 1.0.3'
gem 'friendly_id-mobility', '~> 1.0.3'

gem 'globalize', git: 'https://github.com/globalize/globalize'
gem 'globalize-accessors'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
gem 'newrelic_rpm'

gem 'puma',  '~> 5.5.2'

gem "recaptcha", require: "recaptcha/rails"

gem 'bootsnap', '>= 1.1.0', require: false

gem 'webpacker', '~> 3.5'
gem 'websocket-extensions', '~> 0.1.5'

# Deploy with Capistrano
# Deploy with Capistrano
group :development do
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'

  gem 'execjs'

  gem "better_errors"
  gem "binding_of_caller"

  gem "byebug"
  gem "rails-erd"
  gem 'rb-readline'
  gem 'rubocop'
  gem 'rack-mini-profiler'
  gem 'rbtrace'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'fuubar'
  gem 'rspec-rails'
  gem 'pry'
  gem 'rubocop-rspec'
  gem 'listen'
  gem 'faker', '~> 2.15.1'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'capybara'
  gem 'database_cleaner'
end

group :test do
  gem 'simplecov', require: false
  gem 'coveralls', require: false
end

# To use debugger
# gem 'debugger'

