FROM ruby:3.4.4

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

WORKDIR /app

COPY . .

RUN gem install bundler:2.3.26
RUN bundle install
RUN yarn install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s"]
