FROM ruby:2.1.3

RUN mkdir /code
WORKDIR /code

COPY lib/git-up/version.rb /code/lib/git-up/version.rb
COPY git-up.gemspec /code/git-up.gemspec
COPY Gemfile /code/Gemfile
COPY Gemfile.lock /code/Gemfile.lock
RUN bundle install

COPY . /code
ENTRYPOINT ["rake"]
