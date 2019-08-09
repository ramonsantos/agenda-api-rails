# README

[![Build Status](https://travis-ci.org/ramonsantos/agenda-api-rails.svg?branch=master)](https://travis-ci.org/ramonsantos/agenda-api-rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/d57e7440df5f3a6acc5f/maintainability)](https://codeclimate.com/github/ramonsantos/agenda-api-rails/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d57e7440df5f3a6acc5f/test_coverage)](https://codeclimate.com/github/ramonsantos/agenda-api-rails/test_coverage)

## Setup

### Run Docker containers

``` bash
docker-compose up -d
```

### Install dependencies
``` bash
bundle install
```

### Create and migrate database
``` bash
rake db:create db:migrate
```

### Run application
``` bash
rails server
```

### Run tests
``` bash
rspec
```
