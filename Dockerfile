FROM ubuntu:16.04

ENV APP_PATH /venv
WORKDIR $APP_PATH

RUN set -x \
    &&apt-get update \
    &&apt-get install -y nginx nano vim

RUN set -x \
    && echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get install -y mysql-server

COPY start.sh /venv

RUN set -x \
    && chmod a+x /venv/*

ENTRYPOINT ["/venv/start.sh"]

EXPOSE 80
