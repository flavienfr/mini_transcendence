FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /ft_transcendence
WORKDIR /ft_transcendence
RUN apt-get install -y npm
RUN npm install -g yarn
COPY ./srcs/Gemfile /ft_transcendence/Gemfile
COPY ./srcs/Gemfile.lock /ft_transcendence/Gemfile.lock
RUN bundle install
COPY ./srcs/ /ft_transcendence

#bad to install with old yarn
RUN yarn add jquery && yarn add underscore && yarn add backbone

# Add a script to be executed every time the container starts.
COPY ./srcs/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
RUN bundle exec figaro install
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
