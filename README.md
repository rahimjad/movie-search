# README

## What is Movie Search?
This is a simple ROR API that ingests movie and actor information, stores it into a Postgres DB and presents it via routes.

---

## Requirements
- Must have ruby installed (v 3.0.0)
- Must have postgres installed (v 13.2)

## Steps to get going!
You will need run the following commands to get things running:
- `gem install bundler` 
- `bundle install` (install dependencies)
- `rake db:create` (create the db)
- `rake db:migrate` (runs migrations)
- `rails s` (starts the server)

Content will now be served on `port 3000`, unless you specify otherwise.

## Testing:
Tests have been written in Rspec, feel free to read more [here](https://guides.railsgirls.com/testing-rspec). In order to execute the test suite:
- `bundle exec rspec`
---

## How it works/ Additional notes

There are three main routes to the application:
- `put load_data`
- `get movies`
- `get actors`

The `load_data` route kicks off the `MoveActorFetcher` service, which will pull in and import data from the test URLs provided for the challenge. I decided to usen the `activerecord-import` gem to do a bulk import, there is no data preprocessing occuring, this will simply ingest the `Actors` data, followed by `Movies` data, afterwhich it will create the join table associations. NOTE: I'm maintaining IDs as they were set.

Ideally if the data set was larger, `load_data` should be handling imports and data fetching in batches. Furthermore, given the size of the data set and the fact that it is static, we could have run this via a rake task. If there were a larger data set with next tokens and pagination, I would have done this via sidekiq jobs in the background.

The `get_movies` endpoint returns all movies that match what is sent in the `ids` param. A couple of improvements here could have been to use a presenter for rendering and adding better error handling. For now I simply went with returning the movies as json, and including the actors in that payload. 

The `get_actors` endpoint returns all actors that match what is sent in the `ids` param. Similar improvements as stated above could have been made here. In order to get the "co-actors" I decided to create a singluar query to grab the actor_ids and then a second one to fetch the actors, this could have been done as one query, however, I wanted to leverage some of the ActiveRecord "magic" that comes from returning a set of ActiveRecord models e.g. allowing me to use the `include` syntax when rendering the JSON.