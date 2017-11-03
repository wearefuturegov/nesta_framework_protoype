[![Coverage Status](http://img.shields.io/coveralls/wearefuturegov/nesta_framework_protoype.svg?style=flat-square)](https://coveralls.io/r/wearefuturegov/nesta_framework_protoype)
[![CircleCI](https://img.shields.io/circleci/project/github/wearefuturegov/nesta_framework_protoype.svg?style=flat-square)](https://circleci.com/gh/wearefuturegov/nesta_framework_protoype)

# nesta_framework_protoype

Requirements
------------

* Ruby 2.4.1
* Postgresql 9.0 +

Installation
------------

Clone the repo:

```
git clone git@github.com:wearefuturegov/nesta_framework_protoype.git
```

Run `bundle install`

Run `bundle exec rake db:create`, then `bundle exec rake db:migrate` to set up the database

Run the tests with `bundle exec rake`

If you don't already have any data in the database, run `bundle exec rake assessment:build` to
create the relevant areas, attitudes and skills for the framework. These are defined in
`config/assessment.yml`

Spin up the server with `bundle exec rails server`
