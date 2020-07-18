# frozen_string_literal: true

FactoryBot.define do
  factory :vacation do
    dates_array { [(Date.today + 1.day), (Date.today + 1.day)] }
    diving_objects { [{ 'title': 'divin objects' }] }
    training_objects { [{ 'title': 'training objects' }] }
    number_of_divers { 3 }
    resort { 'Hotel Cozumel & Resort' }
  end
end
