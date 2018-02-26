FROM jubicoy/nginx:stable
MAINTAINER Matti Rita-Kasari "matti.rita-kasari@jubic.fi"

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    supervisor \
    wget \
    php-fpm \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /workdir

COPY root /

RUN  mkdir -p /workdir/sv-child-logs \
  && /usr/libexec/fix-permissions /workdir \
  && /usr/libexec/fix-permissions /var/www \
  && /usr/libexec/fix-permissions /etc/php \
  && /usr/libexec/fix-permissions /etc/supervisor

CMD ["/usr/bin/supervisord"]

