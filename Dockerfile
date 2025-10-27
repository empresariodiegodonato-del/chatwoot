FROM chatwoot/chatwoot:latest

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
