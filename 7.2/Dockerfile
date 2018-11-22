FROM jubicoy/nginx:stable
MAINTAINER Matti Rita-Kasari "matti.rita-kasari@jubic.fi"

COPY apt.gpg /tmp/

RUN apt-get update \
  && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    supervisor \
    wget \
  && cat /tmp/apt.gpg | apt-key add - \
  && echo 'deb https://packages.sury.org/php/ stretch main' > /etc/apt/sources.list.d/php.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y php7.2-fpm \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /workdir

COPY root /

RUN  mkdir -p /workdir/sv-child-logs \
  && /usr/libexec/fix-permissions /workdir \
  && /usr/libexec/fix-permissions /var/www \
  && /usr/libexec/fix-permissions /etc/php \
  && /usr/libexec/fix-permissions /etc/supervisor

CMD ["/usr/bin/supervisord"]

