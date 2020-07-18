# frozen_string_literal: true

class Vacation < ApplicationRecord
  validates :user_id, :dates_array, :number_of_divers, :resort, presence: true
end
