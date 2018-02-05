FROM jubicoy/nginx:full-ubuntu
MAINTAINER Matti Rita-Kasari "matti.rita-kasari@jubic.fi"

RUN apt-get update && \
  apt-get install -y language-pack-en-base && \
  export LC_ALL=en_US.UTF-8 && \
  export LANG=en_US.UTF-8 && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:ondrej/php && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y supervisor gettext wget libnss-wrapper php7.1-fpm && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  mkdir -p /workdir/sv-child-logs

WORKDIR /workdir

COPY . /workdir

RUN cp config/default.conf /etc/nginx/conf.d/default.conf && \
  cp config/nginx.conf /etc/nginx/nginx.conf && \
  cp config/supervisord.conf /etc/supervisor/conf.d/supervisor.conf && \
  cp config/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf && \
  cp config/www.conf /etc/php/7.1/fpm/pool.d/www.conf && \
  chown -R 104:0 /workdir /var/www && \
  chmod -R g+rw /workdir /var/www && \
  chmod -R a+x /workdir

ENTRYPOINT ["/workdir/entrypoint.sh"]
