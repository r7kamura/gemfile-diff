FROM ruby:3.1.2-slim

WORKDIR /app

ENV BUNDLE_GEMFILE /app/Gemfile
ENV BUNDLE_WITHOUT development

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY main.rb /app/

ENTRYPOINT ["/app/entrypoint.sh"]
