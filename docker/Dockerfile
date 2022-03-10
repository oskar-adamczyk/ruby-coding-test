FROM ruby:2.6.6-alpine3.13 as prod

ARG UID=1000
RUN addgroup -g $UID -S ruby && \
    adduser -h /ruby -u $UID -D -S ruby && \
    mkdir /app && \
    chown -R ruby:ruby /ruby /app

RUN apk update && \
  apk -q --update --no-cache add \
  build-base \
  libxml2-dev \
  libxslt-dev \
  ruby-dev \
  libpq \
  postgresql \
  postgresql-client \
  postgresql-dev \
  nodejs \
  npm

RUN bundle config --global frozen 1

USER ruby

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1

WORKDIR /app

COPY --chown=ruby:ruby package.json package-lock.json ./

RUN npm install

COPY --chown=ruby:ruby Gemfile Gemfile.lock ./

RUN bundle config build.pg --with-pg-config=/usr/bin/pg_config && \
    BUNDLE_DEPLOYMENT=1 BUNDLE_WITHOUT=development:test bundle install

COPY --chown=ruby:ruby . ./

CMD ["sh", "/app/docker/entrypoint.sh"]

FROM prod as dev

RUN BUNDLE_WITH=development:test bundle install
