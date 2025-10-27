FROM ruby:3.2.2

ENV RAILS_ENV=production \
    NODE_ENV=production \
    BUNDLE_WITHOUT="development:test"

RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    redis-tools \
    tzdata \
    curl \
    yarn \
    build-essential \
    libpq-dev

WORKDIR /app

COPY . .

RUN gem install bundler && \
    bundle install --jobs=4 --retry=3 && \
    yarn install --production && \
    rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
