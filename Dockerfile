# syntax=docker/dockerfile:1
FROM ruby:2.6.3

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends curl dirmngr apt-transport-https lsb-release ca-certificates nodejs mariadb-server mariadb-client yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Copy dependency definitions
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY package.json /app/package.json
COPY yarn.lock /app/yarn.lock

# Copy app contents
COPY . /app/

# Install dependencies
RUN yarn cache clean
RUN yarn
RUN bundle install
RUN ./bin/rails webpacker:compile

# Copy app contents
COPY . /app/

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
