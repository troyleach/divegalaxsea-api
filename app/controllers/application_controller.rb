# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # FIXME:
  # had the lib folder in the wrong place. moved lib folder into app.
  include Error::ErrorHandler
end
