FROM jubicoy/nginx:stable
MAINTAINER Matti Rita-Kasari "matti.rita-kasari@jubic.fi"

COPY unstable.list /etc/apt/sources.list.d/

RUN apt-get update \
  && apt-get install -y \
    supervisor \
    wget \
  && apt-get install -t unstable -y php7.1-fpm \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /workdir

COPY root /

RUN  mkdir -p /workdir/sv-child-logs \
  && /usr/libexec/fix-permissions /workdir \
  && /usr/libexec/fix-permissions /var/www \
  && /usr/libexec/fix-permissions /etc/php \
  && /usr/libexec/fix-permissions /etc/supervisor

CMD ["/usr/bin/supervisord"]

