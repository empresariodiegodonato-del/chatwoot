FROM ruby:3.4.4

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  curl \
  git \
  nodejs

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g corepack \
  && corepack enable \
  && corepack prepare pnpm@latest --activate

WORKDIR /app

COPY . .

RUN gem install bundler:2.3.26
RUN bundle install --without development test

RUN pnpm install --prod
RUN pnpm build

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
