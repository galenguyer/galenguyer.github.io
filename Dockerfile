FROM docker.io/library/ruby:3.2.2-bullseye AS builder
RUN bundle config --global frozen 1
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs $(nproc)

COPY . .
RUN bundle exec jekyll build

FROM scratch AS files
COPY --from=builder /usr/src/app/_site/ /

FROM docker.io/galenguyer/nginx
COPY --from=builder /usr/src/app/_site/ /usr/share/nginx/html/
