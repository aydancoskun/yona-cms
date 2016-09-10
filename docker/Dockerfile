FROM debian:jessie

RUN export LC_ALL=C.UTF-8
RUN export DEBIAN_FRONTEND=noninteractive
RUN export DEBIAN_PRIORITY=critical

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sudo wget nano zsh htop curl
RUN apt-get install -y python-software-properties software-properties-common

# Nginx
RUN wget http://nginx.org/keys/nginx_signing.key
RUN apt-key add nginx_signing.key
RUN add-apt-repository 'deb http://nginx.org/packages/debian/ jessie nginx'
RUN apt-get update && apt-get install -y nginx

# PHP7, memcached
RUN apt-get install -y php5-fpm php5-memcached memcached

#Phalcon
RUN curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash
RUN sudo apt-get install php5-phalcon


# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
RUN echo "mysql-server mysql-server/root_password password 111" | sudo debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password 111" | sudo debconf-set-selections
RUN apt-get -y install mariadb-server mariadb-client


# Run the MySQL Secure Installation wizard
#RUN sudo mysql_secure_installation

#RUN sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf
#RUN mysql -uroot -p -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

#RUN service mysql restart