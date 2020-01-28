
I18n.available_locales = [:en, :fr]

I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

I18n.backend = I18n::Backend::Simple.new
