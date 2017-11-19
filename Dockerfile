FROM ruby:2.3.3

RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get update && apt-get install -y git curl libpq-dev build-essential nfs-kernel-server nfs-common curl nodejs
RUN apt-get update && apt-get install -y libc-ares2 libv8-3.14.5 postgresql-client nodejs --no-install-recommends
RUN update-alternatives --force --install /usr/bin/node node /usr/bin/nodejs 10

RUN mkdir -p /magic_logger
WORKDIR /magic_logger/

COPY . /magic_logger/
RUN bundle install

EXPOSE 3000
