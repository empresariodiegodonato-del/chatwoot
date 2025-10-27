FROM ruby:3.4.4

ENV RAILS_ENV=production \
    NODE_ENV=production \
    BUNDLE_WITHOUT="development:test"

RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    redis-tools \
    tzdata \
    curl \
    npm \
    build-essential \
    libpq-dev

RUN npm install -g yarn

WORKDIR /app

COPY . .

RUN gem install bundler && \
    bundle install --jobs=4 --retry=3 && \
    yarn install --production --frozen-lockfile && \
    rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
