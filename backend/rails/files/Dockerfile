FROM ruby:{{RUBY_VERSION}}-slim
RUN apt-get update -qq && apt-get install -y build-essential libsqlite3-dev
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN bundle exec rails db:setup
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
