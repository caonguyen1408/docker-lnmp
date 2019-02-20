#!/bin/bash

/etc/init.d/php7.0-fpm start
/etc/init.d/mysql start
/etc/init.d/nginx start
/etc/init.d/mongodb start
ln -s /usr/share/phpmyadmin/ /var/www/htm/
echo "Done phpmyadmin"

