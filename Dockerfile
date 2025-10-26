FROM ruby:3.0.4

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

WORKDIR /app
COPY . .

RUN gem install bundler -v 2.3.26
RUN bundle install
RUN yarn install --check-files

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV PORT=3000

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
