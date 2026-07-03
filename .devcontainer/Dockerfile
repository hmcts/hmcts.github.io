FROM mcr.microsoft.com/devcontainers/ruby:3.3

WORKDIR /workspace

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 4 --retry 3