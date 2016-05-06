FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential
RUN mkdir /todo_app
WORKDIR /todo_app
ADD Gemfile /todo_app/Gemfile
ADD Gemfile.lock /todo_app/Gemfile.lock
RUN bundle install
ADD . /todo_app

ADD .env.sample /todo_app/.env

ENV RAILS_ENV production
RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
