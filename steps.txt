#Lancement
docker-compose up
docker-compose run web yarn install --check-files
docker-compose run web rake db:create
docker-compose run web rake db:migrate

docker-compose run web gem install bootstrap -v 4.5.2