FROM debian:jessie

RUN export LC_ALL=C.UTF-8
RUN export DEBIAN_FRONTEND=noninteractive
RUN export DEBIAN_PRIORITY=critical
RUN export TERM=xterm

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sudo wget nano zsh htop curl git-core
RUN apt-get install -y python-software-properties software-properties-common

# User
RUN adduser --system --shell /bin/sh yona
RUN usermod -a -G sudo yona
RUN usermod -a -G www-data yona
RUN echo "yona ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Nginx
RUN wget http://nginx.org/keys/nginx_signing.key
RUN apt-key add nginx_signing.key
RUN add-apt-repository 'deb http://nginx.org/packages/debian/ jessie nginx'
RUN apt-get update && apt-get install -y nginx
COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/conf.d/yona.conf /etc/nginx/conf.d/yona.conf
RUN rm -f nginx_signing.key

# PHP7, memcached
RUN apt-get install -y php5-fpm php5-memcached php5-intl memcached

# Phalcon
RUN curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash
RUN sudo apt-get install php5-phalcon

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
RUN echo "mysql-server mysql-server/root_password password 111" | sudo debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password 111" | sudo debconf-set-selections
RUN apt-get -y install mariadb-server mariadb-client

# phpMyAdmin
RUN echo "phpmyadmin phpmyadmin/internal/skip-preseed boolean true" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | debconf-set-selections
RUN apt-get install -y phpmyadmin
COPY etc/nginx/conf.d/phpmyadmin.conf /etc/nginx/conf.d/phpmyadmin.conf

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

USER yona
WORKDIR /home/yona

# YonaCMS directory
RUN mkdir /home/yona/www && mkdir /home/yona/www/yona-cms
WORKDIR /home/yona/www

# Startup script, run in container after launch
COPY startup.sh startup.sh

# Share ports
EXPOSE 8080
EXPOSE 8081