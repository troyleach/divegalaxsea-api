# frozen_string_literal: true

FactoryBot.define do
  factory :training do
    title { 'title' }
    price { 4.99 }
    description { 'training description' }
  end
end
