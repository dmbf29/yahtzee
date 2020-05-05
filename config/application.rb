require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yahtzee
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.dsn = 'https://9263ed5aea0f408ab6fa614c2c3747df:3ede26f836c7489f82928542a39d92ae@o158345.ingest.sentry.io/5224156'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
