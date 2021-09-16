#!/bin/bash

set -e

bundle -v

if [[ $CURRENT_ENV = "production" ]] || [[ $CURRENT_ENV = "staging" ]]; then
  bundle install --without development test
else
  bundle install
fi

rm -f tmp/pids/server.pid
rm -f tmp/pids/passenger.3000.pid
rm -f tmp/pids/passenger.3000.pid.lock

bundle exec rails s -p 3000 -b '0.0.0.0'

exec "$@"
