source 'https://rubygems.org'

gem 'rails', '4.2.5' #'3.2.16'

#gem 'railties', '~> 4.2.0' #'3.2.16'

gem 'mysql2', '0.4.2' #'~> 0.3.20'

gem 'mime-types', require: 'mime/types/full'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem "ranked-model"

gem 'uglifier', '~> 2.7.2' #'>= 1.0.3'

# gem 'trumbowyg_rails'

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

# Gems used only for assets and not required
# in production environments by default.
group :assets do
    
      #gem "therubyracer"
      #gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
      #gem "twitter-bootstrap-rails"
end
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
gem 'paperclip', '4.3.6' #'~> 4.2'

# Support for tag inputs
gem 'select2-rails'

# gem "rails-backbone"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

gem "jquery-fileupload-rails"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'rails-i18n' # translations
gem 'i18n-active_record',
      :git => 'git://github.com/svenfuchs/i18n-active_record.git',
      :tag => 'v0.1.0',
      :require => 'i18n/active_record'

# gem 'aws-sdk'
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
end

group :production do
  gem 'puma', '~> 2.15.3' #'2.12.3'
end

# To use debugger
# gem 'debugger'

