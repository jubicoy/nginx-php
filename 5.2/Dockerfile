FROM tommylau/php-5.2
MAINTAINER Matti Rita-Kasari "matti.rita-kasari@jubic.fi"

# Unstable repo for certain packages.
ADD ./apt/unstable.pref /etc/apt/preferences.d/unstable.pref
ADD ./apt/unstable.list /etc/apt/sources.list.d/unstable.list

#RUN apt-get update && apt-get install -y supervisor gettext bzip2 g++ gcc build-essential libxml2-dev libssl-dev libmysqlclient-dev libxslt-dev libmcrypt-dev libfcgi-dev libcurl4-openssl-dev pkg-config libsasl2-dev autoconf libbz2-dev libjpeg-dev
RUN apt-get update && apt-get install -y supervisor gettext nginx

# nss-wrapper for OpenShift user management.
RUN apt-get update && apt-get install -y -t unstable libnss-wrapper

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create some needed directories
RUN mkdir -p /workdir/sv-child-logs

# Add configuration files
ADD config/default.conf /etc/nginx/conf.d/default.conf
ADD config/nginx.conf /etc/nginx/nginx.conf
ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD config/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD config/www.conf /etc/php5/fpm/pool.d/www.conf
ADD passwd.template /workdir/passwd.template

# Add entrypoint script
ADD entrypoint.sh /workdir/entrypoint.sh

# Fix permissions issues
RUN chown -R 104:0 /workdir && chown -R 104:0 /var/www
RUN chmod -R g+rw /workdir && chmod -R a+x /workdir && chmod -R g+rw /var/www
RUN chmod -R 777 /var/run

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY fix-permissions /usr/libexec/fix-permissions
RUN mkdir -p /run/nginx /var/cache/nginx \
  && /usr/libexec/fix-permissions /run/nginx \
  && /usr/libexec/fix-permissions /var/cache/nginx \
  && /usr/libexec/fix-permissions /var/lib/nginx \
  && /usr/libexec/fix-permissions /etc/nginx \
  && /usr/libexec/fix-permissions /var/log/nginx

WORKDIR /workdir

ENTRYPOINT ["/workdir/entrypoint.sh"]
