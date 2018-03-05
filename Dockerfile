FROM debian:testing-slim
MAINTAINER Miles Elam <miles@geekspeak.org>
RUN apt-get update && \
    apt-get install -y postgresql-10 \
                       postgresql-contrib \
                       postgresql-10-python3-multicorn \
                       postgresql-10-cron \
                       postgresql-10-pllua

RUN echo "host  all  all  0.0.0.0/0  trust" >> /etc/postgresql/10/main/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf

ADD https://raw.githubusercontent.com/ttfkam/pg_geekspeak/master/geekspeak--1.0.0.sql /usr/share/postgresql/10/extension
ADD https://raw.githubusercontent.com/ttfkam/pg_geekspeak/master/geekspeak.control /usr/share/postgresql/10/extension
ADD https://raw.githubusercontent.com/ttfkam/pg_gnufind/master/gnufind/__init__.py /usr/lib/python3/dist-packages/gnufind
COPY *.sql /docker-entrypoint-initdb.d

EXPOSE 5432

ENV POSTGRES_USER=geekspeak_web
ENV POSTGRES_DB=geekspeak
ENV PGDATA=/var/lib/postgresql/data/pgdata
