Set variables:

1 - config/database.yml production section

2 - config/deploy.rb set server, repo, app name, user

3 - config/environment set smtp mailer settings

4 - config/initializers/active_admin.rb set config.site_title

5 - config/provision/configs/application.yml set variables

6 - config/provision/configs/database.yml set password

7 - config/provision/keys/ set keys

8 - config/provision/playbook.yml set app_name

9 - app/views/layouts/application.html.erb - set titile


Up dev environment:

1  - download docker for mac - https://download.docker.com/mac/stable/Docker.dmg

2 - cd to project path

3 - Start daemon - docker-compose up

4 - Create database - docker-compose run webapp rake db:create

5 - Migrations - docker-compose run webapp rake db:migrate

6 - Seed - docker-compose run webapp rake db:seed


Stop and remove dev environment:

1 - docker-compose down

2 - docker stop $(docker ps -a -q)

3 - docker rm $(docker ps -a -q)

4 - docker rmi $(docker images -a -q)


Check docker images:

1 - list docker processes - docker ps

2 - show all images - docker images
