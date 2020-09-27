# frozen_string_literal: true

# Trying to fix issue of deploying to Heroku
# class ApplicationController < ActionController::Base
class ApplicationController < ActionController
  include Error::ErrorHandler
end
