#!/bin/sh

bundle exec rubocop --format progress --format json --out ./results/rubocop.json || exit 1
