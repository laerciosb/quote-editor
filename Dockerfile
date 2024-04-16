# syntax = docker/dockerfile:1

################################################################################
# Base
################################################################################

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION-alpine AS base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV LANG="C.UTF-8" \
    RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_WITHOUT="development test" \
    BUNDLE_PATH="/usr/local/bundle"

# Add default dependencies
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache --update postgresql-dev bash tzdata

################################################################################
# Builder
################################################################################

# Throw-away build stage to reduce size of final image
FROM base AS builder

# Install packages needed to build gems
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache --update build-base jemalloc-dev

# Copy application code
COPY . .

# Builder Dependencies and remove unneeded files (cached *.gem, *.o, *.c)
RUN gem install bundler -v "$(grep -A 1 'BUNDLED WITH' Gemfile.lock | tail -n 1)" --no-document && \
    bundle install --jobs "$(nproc)" --retry 3 && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    find "${BUNDLE_PATH}"/ -name "*.c" -delete -o -name "*.o" -delete -o -name "*.gem" -delete && \
    bundle exec bootsnap precompile --gemfile

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

################################################################################
# Production
################################################################################

# System Dependencies
FROM base AS runtime

# Builder Arguments
ARG NON_ROOT_UID=1000

# System Enviromnents
ENV LD_PRELOAD=/usr/lib/libjemalloc.so.2 \
    MALLOC_CONF="narenas:2,background_thread:true,thp:never,dirty_decay_ms:1000,muzzy_decay_ms:0" \
    RUBY_YJIT_ENABLE=1

# From images
COPY --from=builder /usr/lib/libjemalloc.so.2 /usr/lib/
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN adduser -D -u $NON_ROOT_UID -g $NON_ROOT_UID -s /bin/bash rails && \
    chown -R rails:rails /rails
USER rails:rails
