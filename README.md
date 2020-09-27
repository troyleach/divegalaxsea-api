# DIVEGALAXSEA-API
[divegalaxsea.com](http://divegalaxsea.com/)

Rails version
```
rails 6.0.2
```

Ruby version

```
  ruby 2.7.0p0
```

### Install dependencies

```
bundle && yarn
```

### Configuration

* More to come...

### Initialize the database

```
rails db:create db:migrate db:seed
```

# Serve
```
rails s
```


# Services (job queues, cache servers, search engines, etc.)

* none at this time

# Deployment instructions
Deployed to Heroku, only staging at the moment

`git push staging`

* More to come...

# Testing

#### How to run the test suite

```
bundle exec rspec
```
Run individual test suite
```
bundle exec rspec spec/controllers/api/v1/users_controller_spec.rb
```
Run individual test
```
bundle exec rspec spec/controllers/api/v1/users_controller_spec.rb:14
```

> Avoid using Faker. This creates data that is not testable because the data
is not consistent. 

[Faker](https://github.com/faker-ruby/faker)


### Test coverage
[simmplecov](https://github.com/simplecov-ruby/simplecov)

To see the test coverage run:
In a mac terminal

```
open coverage/index.html
```

* note: if this is your first time opening this app you will need to run bundel exec rspec then run the above command



#### Factory Bot
[Factory Bot repo](https://github.com/thoughtbot/factory_bot/wiki)

[Factory Bot cheat sheet](https://devhints.io/factory_bot)

#### Mocking
[webmock](https://github.com/bblimke/webmock)

[video on mocking](https://www.youtube.com/watch?v=Okck4Fc557o)

# Resources
[Ruby on Rails testing: RSpec configuration](https://hixonrails.com/ruby-on-rails-tutorials/ruby-on-rails-testing-rspec-configuration/)

[Enviroonment credentials](https://blog.saeloun.com/2019/10/10/rails-6-adds-support-for-multi-environment-credentials.html)
