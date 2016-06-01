# See if we can load Rails -- but don't fail if we can't; we'll just use this to decide whether we should
# load the Railtie or not.
begin
  gem 'rails'
rescue Gem::LoadError => le
  # ok
end

begin
  require 'rails'
rescue LoadError => le
  # ok
end

if defined?(::Rails)
  require 'action_view'

  require 'fortitude/rails/widget_methods'
  require 'fortitude/rails/renderer'
  require 'fortitude/rails/template_handler'
  require 'fortitude/rails/railtie'
else
  ::String.class_eval do
    alias_method :original_concat, :concat
  end
end
