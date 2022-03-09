#!/bin/sh

until nc -z $DATABASE_HOST $DATABASE_PORT; do sleep 1; done

bundle exec rake db:create
bundle exec rake db:migrate || exit 1
bundle exec rspec --format progress --format RspecJunitFormatter --out ./coverage/rspec.xml || exit 1
