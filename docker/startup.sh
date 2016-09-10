#!/usr/bin/env bash

service nginx start
service mysql start
service php5-fpm start
service memcached start

mysql -u root -p111 -e "CREATE DATABASE yona;"
mysql -u root -p111 yona < yona-cms.sql