# frozen_string_literal: true

class Rental < ApplicationRecord
  validates :title, :price, presence: true
end
