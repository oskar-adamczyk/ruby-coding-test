#!/bin/sh

until nc -z $DATABASE_HOST $DATABASE_PORT; do sleep 1; done

bundle exec rake db:create
bundle exec rake db:migrate || exit 1
bundle exec rspec || exit 1
