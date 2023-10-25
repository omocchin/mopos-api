# README

Steps of installation

$ docker-compose run --rm web rails new . --force --database=mysql --api

$ docker-compose run --rm web rails db:create

$ docker-compose up

Access rails console
$ docker-compose exec web rails c

Apply ridgepole
$ docker-compose exec web bundle exec ridgepole -c config/database.yml -f db/Schemafile --apply 

Generate model
$ docker-compose exec web rails generate model <model_name> --no-migration