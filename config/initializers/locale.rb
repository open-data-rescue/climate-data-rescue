
require 'i18n/backend/active_record'
I18n.backend = I18n::Backend::ActiveRecord.new

I18n.available_locales = [:en, :fr]

#
I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Flatten)
I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

I18n::Backend::Chain.send(:include, I18n::Backend::ActiveRecord::Missing) unless  Rails.env.production? || Rails.env.prime? ||  Rails.env.sites_prime? # Only do if env is dev or staging
I18n.backend = I18n::Backend::Chain.new(I18n::Backend::Simple.new, I18n.backend)
