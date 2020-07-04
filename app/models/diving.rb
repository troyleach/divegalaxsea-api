# frozen_string_literal: true

class Diving < ApplicationRecord
  validates :title, :price, presence: true
end
