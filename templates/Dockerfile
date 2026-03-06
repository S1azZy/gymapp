# syntax=docker/dockerfile:1.7
# Placeholder Dockerfile for Codex to adapt after Rails app generation
# Ruby 4+ target; until Ruby 4 stable GA use latest stable Ruby 3.4.x
ARG RUBY_VERSION=3.4.7
FROM ruby:${RUBY_VERSION}-slim

WORKDIR /app

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  nodejs \
  npm \
  git \
  curl \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN --mount=type=cache,target=/usr/local/bundle/cache \
  bundle config set path '/usr/local/bundle' && \
  bundle install

COPY . .

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
