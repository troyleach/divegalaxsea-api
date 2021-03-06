# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DivegalaxseaApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Trying to debug what is happening on Heroku, seem I get this this deployed
    Rails.autoloaders.logger = method(:puts)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # NOTE: maybe only run this in test mode? see what the evn is then if test run this?
    # I ran into all kinds of issues deploying this to Heroku, once I set lin 30 the API deployed successfully
    # https://stackoverflow.com/questions/57277351/rails-6-zeitwerknameerror-doesnt-load-class-from-module
    # I did this so the tests would work
    p 'My env is TEST' if Rails.env === 'test'
    p 'My env is production' if Rails.env === 'production'
    config.autoloader = :classic
  end
end
