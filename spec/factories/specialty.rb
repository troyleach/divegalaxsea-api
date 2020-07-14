# frozen_string_literal: true

FactoryBot.define do
  factory :specialty do
    title { 'specialty title' }
    price { 4.99 }
    description { 'specialty description' }
  end
end
