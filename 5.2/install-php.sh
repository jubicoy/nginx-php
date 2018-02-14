#!/bin/bash

cd /usr/src
curl http://museum.php.net/php5/php-5.2.17.tar.bz2 --output php-5.2.17.tar.bz2

tar xvf php-5.2.17.tar.bz2
gzip -cd php-5.2.17-fpm-0.5.14.diff.gz | patch -d php-5.2.17 -p1

cd php-5.2.17
./configure --enable-fastcgi --enable-fpm --with-mcrypt --with-zlib --enable-mbstring --enable-pdo --with-curl --disable-debug --with-pic --disable-rpath --enable-inline-optimization --with-bz2 --enable-xml --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --with-mhash --with-xsl --enable-zip --with-pcre-regex --with-gd --without-pdo-sqlite --with-pdo-mysql --without-sqlite --with-jpeg-dir=/usr/lib --with-png-dir=/usr/lib --with-mysql --enable-bcmath --enable-calendar --enable-exif --enable-ftp --with-gettext --with-imap --with-mysqli --with-openssl --with-kerberos --with-imap-ssl --enable-dbase --with-gmp --enable-shmop --enable-wddx
make all install
strip /usr/local/bin/php-cgi
cp sapi/cgi/fpm/php-fpm /etc/init.d/
chmod +x /etc/init.d/php-fpm

cp /usr/src/php-5.2.17/php.ini-recommended /usr/local/lib/php.ini
mkdir /etc/php/
ln -s /usr/local/lib/php.ini /etc/php/php.ini
ln -s /usr/local/etc/php-fpm.conf /etc/php/php-fpm.conf