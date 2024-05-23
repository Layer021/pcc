FROM ruby:3.2.3

RUN apt-get update -qq && apt-get install -y nodejs npm default-mysql-client
RUN npm install -g yarn

WORKDIR /project/pcc

COPY Gemfile /project/pcc/Gemfile
COPY Gemfile.lock /project/pcc/Gemfile.lock

RUN bundle install

COPY . /project/pcc

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
