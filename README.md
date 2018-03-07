App link: https://obeybot.herokuapp.com/

Up dev environment:

1  - download docker for mac - https://download.docker.com/mac/stable/Docker.dmg

2 - cd to project path

3 - Start daemon - docker-compose up

4 - Create database - docker-compose exec webapp rake db:create

5 - Migrations - docker-compose exec webapp rake db:migrate

6 - Seed - docker-compose exec webapp rake db:seed
