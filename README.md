# RSS Reader Application

In order to have this application running locally you will need to to the following :

* bundle install

* yarn install

* rails db:create db:migrate

Then

* rails server

Caching is being made using redis, that needs to be installed locally as well.

Unit tests and feature tests can be executed using `bundle exec rspec` while the linters for rubocop, stylelint and eslint can be executed using `bin/lint`

The app is also available on [https://rss-feeds-reader.herokuapp.com](https://rss-feeds-reader.herokuapp.com) , try it out.
