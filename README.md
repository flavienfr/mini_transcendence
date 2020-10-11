# README

# Docker
Stop all running containers:
* docker stop $(docker ps -a -q)

Delete all stopped containers:
* docker rm $(docker ps -a -q)

Remove all images:
* docker rmi $(docker images -q)
