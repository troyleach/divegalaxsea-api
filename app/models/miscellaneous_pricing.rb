# frozen_string_literal: true

class MiscellaneousPricing < ApplicationRecord
  validates :title, :price, presence: true
end
