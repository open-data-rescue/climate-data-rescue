source 'https://rubygems.org'

ruby '2.7.3'

gem 'rails', '~> 6.1'

gem 'mysql2'

gem 'mime-types', require: 'mime/types/full'

gem 'paper_trail'
gem "ranked-model"

gem 'uglifier'

#bootstrap stuff
gem 'sass-rails'

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

gem 'with_advisory_lock'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'jsonapi-rails'
gem 'jsonapi-rspec'

gem 'routing-filter'

gem 'http_accept_language'

gem 'rails-i18n'
gem 'i18n-active_record', :require => 'i18n/active_record'
# gem 'i18n-tasks'

gem 'rails-observers'

gem 'friendly_id', '~> 5.4.2'
gem 'mobility', '~> 1.0.3'
gem 'friendly_id-mobility', '~> 1.0.3'

gem 'globalize', '~> 6.3' # TODO: change when Rails upgrades
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
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
