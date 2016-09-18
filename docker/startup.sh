#!/bin/bash

sudo service nginx start
sudo service mysql start
sudo service php5-fpm start
sudo service memcached start

mysql -u root -p111 -e "CREATE DATABASE yona;"
mysql -u root -p111 yona < yona-cms/yona-cms.sql

cd yona-cms && composer install