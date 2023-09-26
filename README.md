# README

Steps of installation

$ docker-compose run --rm web rails new . --force --database=mysql --api

$ docker-compose run --rm web rails db:create

$ docker-compose up

Access rails console
$ docker exec -it mipos-api-web-1 /bin/bash