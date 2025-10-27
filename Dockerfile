FROM ghcr.io/chatwoot/chatwoot:v3.0.0

ENV NODE_ENV=production
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

RUN bundle config set --local without 'development test' \
 && yarn config set ignore-engines true

CMD ["bash", "-c", "bundle exec rails db:prepare && bundle exec puma -C config/puma.rb"]
