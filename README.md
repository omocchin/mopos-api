# README

The backend for a POS System called "mopos".<br>
This is a SaaS web application that will have a capability of a POS System, employee's shift management, and employee pay management.<br>
It is a server side of the web application using, Ruby on Rails with rails grape gem.<br>
Still in progress of building the web application.

Frontend of the web application below.<br>
Also still in progress of development.<br>
[Mopos frontend](https://github.com/omocchin/mopos-front/tree/release/v1)

<h3>Steps of installation</h3>

$ docker-compose run --rm web rails new . --force --database=mysql --api

$ docker-compose run --rm web rails db:create

$ docker-compose up
