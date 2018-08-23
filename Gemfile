source 'https://rubygems.org'

gem 'rails', '~> 4.2.7.1'

gem 'mysql2', '0.4.2'

gem 'mime-types', require: 'mime/types/full'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem "ranked-model"

gem 'uglifier', '~> 2.7.2'

#bootstrap stuff
gem 'sass-rails', '~> 5.0'
#gem 'sprockets-rails'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'modernizr-rails'

gem "figaro"
gem 'log4r'

#for user authentication
gem 'devise', '~> 3.5.4' #"3.2"
gem 'cancan', '~> 1.6.10'

#to handle .slim files
gem 'slim-rails', '~> 3.0.1' # view templates

#for forms
gem 'simple_form', '~> 3.2.1' #'2.1.3'
gem 'will_paginate', '3.1.0' #'~> 3.0.6'

#for attachments
gem 'paperclip', '~> 5.2.0'

# Support for tag inputs
gem 'select2-rails'

# gem "rails-backbone"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

gem "jquery-fileupload-rails"

gem 'routing-filter'

gem 'http_accept_language'

gem 'rails-i18n', '~> 4.0.0' # translations
gem 'i18n-active_record', :require => 'i18n/active_record'

gem 'rails-observers'

gem 'globalize'
gem 'globalize-accessors'

gem 'interpret', :git => 'git://github.com/balen/interpret.git', :branch => 'upgrade/rails4'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
gem 'newrelic_rpm'

# Deploy with Capistrano
group :development do
  gem 'capistrano', '~> 3.4.0'#'~> 3.1'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.1.4' #'~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.6' #'~> 1.1'
  gem 'capistrano3-puma'
  
  gem 'execjs'
  #web server - better than WEBrick
  gem 'thin', '~>1.6.4' #'~> 1.6.3'

  gem "better_errors"
  gem "binding_of_caller"

  gem "byebug"
  gem "rails-erd"
  gem 'rb-readline'
  gem 'rubocop'
  gem 'rack-mini-profiler'
  gem 'rbtrace'
end

group :development, :test do
  gem 'fuubar'
  gem 'rspec-rails'
  gem 'pry'
  gem 'listen'
  gem 'faker', '~> 1.9.1'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
end

group :test do
  gem 'simplecov', require: false
  gem 'coveralls'
end

group :production do
  gem 'puma', '~> 2.15.3' #'2.12.3'
end

# To use debugger
# gem 'debugger'

