App link: https://obeybot.herokuapp.com/
Admin path: https://obeybot.herokuapp.com/admin (login: admin@example.com, pass: password)
Bot link: https://t.me/ObeyBot

Up dev environment:

1  - download docker for mac - https://download.docker.com/mac/stable/Docker.dmg

2 - cd to project path

3 - Start daemon - docker-compose up

4 - Create database - docker-compose exec webapp rake db:create

5 - Migrations - docker-compose exec webapp rake db:migrate

6 - Seed - docker-compose exec webapp rake db:seed

7 - Set app variables to config/apllication.yml ( APP_NAME, APP_HOST, TELEGRAM_BOT_NAME, TELEGRAM_BOT_LINK, TELEGRAM_BOT_KEY, SECRET_KEY_BASE, DEVISE_SECRET_KEY)

8 - Home page: localhost:3000, Admin page: localhost:3000/admin (admin@example.com, password), Bot link: https://t.me/ObeyBot
