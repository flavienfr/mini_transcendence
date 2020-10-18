FROM timbru31/ruby-node:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /ft_transcendence
WORKDIR /ft_transcendence
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
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
