# frozen_string_literal: true

class Specialty < ApplicationRecord
  validates :title, :price, presence: true
end
