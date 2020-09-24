# frozen_string_literal: true

module RequestDataSpecHelper
  # Parse JSON response to ruby hash
  def reservation_data
    {
      "user": {
        "first_name": 'pam',
        "last_name": 'baker',
        "email": 'pam.backer@email.com',
        "admin": false
      },
      "vacation": {
        "number_of_divers": 3,
        "resort": 'resort name',
        "diving_objects": [{
          "title": 'title of diving',
          "price": 10.99,
          "description": 'diving description'
        }],
        "training_objects": [{
          "title": 'title of training',
          "price": 11.99
        }, {
          "title": 'title of training',
          "price": 9.99,
          "description": 'training description'
        }],
        "dates_array": %w[2020-07-20 2020-07-23]
      }
    }
  end
end
