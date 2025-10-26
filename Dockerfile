# Usa Ruby e Node
FROM ruby:3.2.2

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  imagemagick \
  git \
  curl

# Define diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Instala gems
RUN gem install bundler && bundle install

# Instala dependências JS
RUN yarn install --frozen-lockfile

# Compila assets
RUN RAILS_ENV=production bundle exec rails assets:precompile

# Expõe a porta
EXPOSE 3000

# Comando para iniciar o Chatwoot
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
