FROM ruby:3.4.4

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  curl

# Instala Node.js 16 e Yarn (versões compatíveis com Chatwoot)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn

WORKDIR /app

COPY . .

RUN gem install bundler:2.3.26
RUN bundle install
RUN yarn install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s"]
