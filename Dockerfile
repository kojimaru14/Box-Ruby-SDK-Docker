FROM ruby:3.0.2

WORKDIR '/app'

COPY Gemfile .
RUN bundle
COPY . .

RUN bundle install
CMD ["ruby", "/app/entry.rb"]