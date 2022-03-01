FROM ruby:2.7 as base

RUN apt-get update -qq && apt-get install -y build-essential curl gnupg
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get install -y nodejs

RUN gem install -n /usr/local/bin bundler

RUN node -v
RUN npm -v

ENV APP_HOME /product-page
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY . $APP_HOME

RUN bundle install
RUN npm install

EXPOSE 4567

ENTRYPOINT [ "bundle", "exec", "middleman", "server" ]
