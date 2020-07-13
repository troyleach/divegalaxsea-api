# frozen_string_literal: true

class Training < ApplicationRecord
  validates :title, :price, presence: true
end
