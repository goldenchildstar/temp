FROM ruby:2.6


RUN apt-get update -qq && apt-get install -y build-essential nodejs postgresql-client && rm -rf /var/lib/apt/lists/*

ENV RAILS_ROOT /usr/src/app
RUN mkdir -p ${RAILS_ROOT}
WORKDIR ${RAILS_ROOT}


COPY Gemfile ${RAILS_ROOT}
# COPY Gemfile.lock ${RAILS_ROOT}

# RUN bundle config --global frozen 1
ENV BUNDLER_WITHOUT="development test"
RUN bundle install --jobs 20 --retry 5 --without development test

ENV RAILS_ENV production
ENV RACK_ENV production

ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY . ${RAILS_ROOT}
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
