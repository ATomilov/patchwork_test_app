ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-buster

ARG BUNDLER_VERSION

# Common dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3


ARG APP_USER=dockeruser
ARG APP_HOME=/home/${APP_USER}/project/api

RUN useradd -ms /bin/bash ${APP_USER}

USER $APP_USER
WORKDIR $APP_HOME

# Install required Bundler version
RUN gem install bundler:$BUNDLER_VERSION

COPY docker/api/docker-entrypoint.sh /

ENTRYPOINT ["bash", "/docker-entrypoint.sh"]
