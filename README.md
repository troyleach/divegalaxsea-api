# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
Setting up project environment variables
https://blog.saeloun.com/2019/10/10/rails-6-adds-support-for-multi-environment-credentials.html

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* Testing

Avoid using Faker. This creates data that is not testable because the data
is not consistent. 
Faker
https://github.com/faker-ruby/faker

### Test coverage
To see the test coverage run:
`open coverage/index.html` if in a mac terminal
note: if this is your first time opening this app you will need to run bundel exec rspec then run the above command
[simmplecov](https://github.com/simplecov-ruby/simplecov)


### Factory Bot
[Factory Bot repo](https://github.com/thoughtbot/factory_bot/wiki)
[Factory Bot cheat sheet](https://devhints.io/factory_bot)

### Mocking
[webmock](https://github.com/bblimke/webmock)
[video on mocking](https://www.youtube.com/watch?v=Okck4Fc557o)

#### Resources
[Ruby on Rails testing: RSpec configuration](https://hixonrails.com/ruby-on-rails-tutorials/ruby-on-rails-testing-rspec-configuration/)