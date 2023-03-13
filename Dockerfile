FROM ruby:3.2.1

LABEL maintainer="ayoblindstone@gmail.com"

ARG RAILS_ROOT=/budvest
ARG PACKAGES="nodejs"

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends $PACKAGES
RUN npm install --global yarn

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile* $RAILS_ROOT

ENV BUNDLE_PATH /bundle_cache

RUN bundle

COPY . $RAILS_ROOT

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/dev"]
