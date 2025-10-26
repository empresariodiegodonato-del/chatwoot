FROM ruby:3.4.4

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  curl

# Instala Node.js 18 e habilita Corepack (Yarn 3)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && corepack enable \
  && corepack prepare yarn@stable --activate

WORKDIR /app

COPY . .

RUN gem install bundler:2.3.26
RUN bundle install

# Garante Yarn 3 compatível com o Chatwoot
RUN yarn set version stable
RUN yarn install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s"]
