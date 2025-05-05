ARG RUBY_VERSION
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS build

WORKDIR /app

ENV BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY redirects.yml redirect-woozle.conf.erb generate_nginx_conf.rb ./
RUN bundle exec ruby generate_nginx_conf.rb > redirect-woozle.conf

FROM docker.io/library/nginx:1.28.0-alpine
COPY --from=build /app/redirect-woozle.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
