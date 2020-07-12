# frozen_string_literal: true

module Error::Helpers
  class Render
    def self.json(error, status, message)
      {
        status: status,
        error: error,
        message: message
      }.as_json
    end
  end
end
