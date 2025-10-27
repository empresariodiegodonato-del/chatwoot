FROM ruby:3.4.4

# Dependências necessárias
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  curl \
  git

# Node.js e pnpm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && corepack enable \
  && corepack prepare pnpm@latest --activate

WORKDIR /app

COPY . .

RUN gem install bundler:2.3.26
RUN bundle install

# Instala dependências Javascript via pnpm
RUN pnpm install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s"]
