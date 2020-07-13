# frozen_string_literal: true

FactoryBot.define do
  factory :rental do
    title { 'rental title' }
    price { 4.99 }
    description { 'rental description' }
  end
end
