FROM ruby:2.6.3

RUN apt-get update && apt-get -y install build-essential nodejs postgresql postgresql-contrib

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get install -y nodejs
RUN apt-get update && apt-get install -y yarn

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

ENV NODE_PATH=/node_modules

RUN mkdir -p /app
ADD package.json /app/
WORKDIR /app
RUN yarn install


COPY . .
RUN rm -f ./Gemfile.lock

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]


LABEL maintainer="Alexander Chernov <boss@beone.software>"
EXPOSE 3000
CMD puma -C config/puma.rb
