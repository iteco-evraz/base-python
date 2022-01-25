# MySQL
$ docker run -d --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -p 3306:3306 mysql

# MariaDB
docker run -d \
  -p 3306:3306 \
  --name some-mariadb \
  --env MARIADB_DATABASE=blog_app \
  --env MARIADB_USER=example-user \
  --env MARIADB_PASSWORD=my_cool_secret \
  --env MARIADB_ROOT_PASSWORD=my-secret-pw \
  mariadb:latest
