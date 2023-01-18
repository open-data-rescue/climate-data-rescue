source 'https://rubygems.org'

ruby '2.7.3'

gem 'rails', '~> 7.0'

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
gem 'execjs'

gem 'modernizr-rails'

gem "figaro"
gem 'log4r'

#for user authentication
gem 'devise'
gem 'pundit'

#to handle .slim files
gem 'slim-rails'

#for forms
gem 'simple_form'
gem 'will_paginate'

#for attachments
gem 'paperclip'
# gem 'aws-sdk-s3', '~> 1'

# Support for tag inputs
gem 'select2-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'jsonapi-rails'
gem 'jsonapi-rspec'

gem "jquery-fileupload-rails"

gem 'routing-filter'

gem 'http_accept_language'

gem 'rails-i18n'
gem 'i18n-active_record', :require => 'i18n/active_record'
# gem 'i18n-tasks'

gem 'rails-observers'

gem 'friendly_id', '~> 5.4.2'
gem 'mobility', '~> 1.0.3'
gem 'friendly_id-mobility', '~> 1.0.3'

gem 'globalize', '~> 6.0' # TODO: change when Rails upgrades
gem 'globalize-accessors'

gem "sidekiq"
gem "sidekiq-scheduler"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
gem 'newrelic_rpm'

gem 'puma', '>= 5.0'

gem "recaptcha", require: "recaptcha/rails"

gem 'bootsnap', '>= 1.4.4', require: false

# gem 'webpacker', '~> 3.5'
gem 'webpacker', '~> 5.0'
gem 'websocket-extensions', '~> 0.1.5'

group :development do
  # What is this used for?
  # gem 'execjs'

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
  gem 'spring-watcher-listen', '~> 2.1.0'
end

group :development, :test do
  gem 'brakeman'
  gem 'fuubar'
  gem 'rspec-rails'
  gem 'pry'
  gem 'rubocop-rspec'
  gem 'listen'
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  # gem 'capybara'
  gem 'database_cleaner'
end

group :test do
  gem 'simplecov', require: false
end

# To use debugger
# gem 'debugger'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
