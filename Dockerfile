FROM ubuntu:16.04

RUN apt-get update
RUN apt-get upgrade -y
#Install toll
RUN apt-get install -y git curl wget vim nano 

#install nginx 
RUN apt-get -y install nginx
 
#Install php
RUN apt-get -y install php php-fpm

#Install mysql
RUN apt-get -y install mariadb-common mariadb-server mariadb-client

#Install nodejs version 6.10
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get install nodejs

#Install MongoDB 
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
  echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/* && \
  chmod 777 /var/lib/mongodb	

#Install expect


RUN \ 
     apt-get update;\
     apt-get install -y expect
CMD ['systemctl restart mysql']
# Install phpMyAdmin

RUN echo '#!/usr/bin/expect -f' > install-phpmyadmin.sh; \
    echo "set timeout -1" >> install-phpmyadmin.sh; \
    echo "spawn apt-get install -y phpmyadmin" >> install-phpmyadmin.sh; \
    echo "expect \"Configure database for phpmyadmin with dbconfig-common?\"" >> install-phpmyadmin.sh; \
    echo "send \"y\r\"" >> install-phpmyadmin.sh; \
    echo "expect \"MySQL application password for phpmyadmin:\"" >> install-phpmyadmin.sh; \
    echo "send \"1qa2ws3ed\r\"" >> install-phpmyadmin.sh; \
    echo "expect \"Password confirmation:\"" >> install-phpmyadmin.sh; \
    echo "send \"1qa2ws3ed\r\"" >> install-phpmyadmin.sh; \
    echo "expect \"Web server to reconfigure automatically:\"" >> install-phpmyadmin.sh; \
    echo "send \"1\r\"" >> install-phpmyadmin.sh
RUN chmod +x install-phpmyadmin.sh

RUN \
    service mysql start; \
    service nginx start; \
    sleep 5; \
    ./install-phpmyadmin.sh; \
    sleep 10; \
    mysqladmin -u root shutdown

RUN ln -s /usr/share/phpmyadmin /var/www/html
RUN chmod -R 775 /usr/share/phpmyadmin/
RUN chmod -R 775 /var/www/html/phpmyadmin/
ADD default /usr/local/bin
ADD run.sh /run.sh
RUN chmod +x /run.sh
RUN \
    rm -rf /etc/nginx/sites-available/default;\
    cp /usr/local/bin/default /etc/nginx/sites-available/

RUN rm install-phpmyadmin.sh
CMD ['/etc/init.d/nginx restart'] 
CMD ['/etc/ini.d/php7.0-fpm restart']
VOLUME /var/www/html
VOLUME /var/log/httpd
VOLUME /var/lib/mysql
VOLUME /var/log/mysql
VOLUME /var/mongo

EXPOSE 80 3306 27017 28017 9000

CMD ["nginx", "-g", "daemon off;"]
