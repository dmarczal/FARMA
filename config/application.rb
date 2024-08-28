require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Farma
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W[#{config.root}/lib/simple_form_extensions]
    config.autoload_paths += %W[#{config.root}/lib/breadcrumbs_on_rails_extensions]
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Adicionando ao eager_load_paths para o ambiente de produção
    config.eager_load_paths += Dir["#{Rails.root}/lib/**/"]
    config.eager_load_paths += %W[#{Rails.root}/lib/simple_form_extensions]
    config.eager_load_paths += %W[#{Rails.root}/lib/breadcrumbs_on_rails_extensions]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = :'pt-BR'

    ENV.update YAML.load_file('config/application.yml')[Rails.env]
  end
end
