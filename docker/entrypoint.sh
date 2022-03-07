#!/bin/sh

bundle exec rails db:migrate || exit 1

rm -f `pwd`/tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0
