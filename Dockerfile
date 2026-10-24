FROM ruby:3.1.2-slim@sha256:5d413e301f37cbe63a54dadded2f347496165c1de0dbe342d1f0f0d47e25b2be

WORKDIR /app

ENV BUNDLE_GEMFILE /app/Gemfile
ENV BUNDLE_WITHOUT development

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY entrypoint.sh main.rb /app/

ENTRYPOINT ["/app/entrypoint.sh"]
