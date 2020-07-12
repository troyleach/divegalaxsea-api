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

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # NOTE: maybe only run this in test mode? see what the evn is then if test run this?
    # seems to work in develop
    # https://stackoverflow.com/questions/57277351/rails-6-zeitwerknameerror-doesnt-load-class-from-module
    # I did this so the tests would work
    p 'My env is TEST' if Rails.env === 'test'
    config.autoloader = :classic
  end
end
