FROM debian:bookworm

RUN apt update && apt install -y fish
RUN apt update && apt install -y mariadb-server  mariadb-client

RUN mkdir /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

RUN apt update && apt install -y net-tools fish

COPY ./tools/entrypoint.sh /usr/bin/entrypoint.sh
COPY ./conf/wordpress.sql  /usr/local/bin/wordpress.sql

RUN chmod +x /usr/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/wordpress.sql

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

CMD ["mysqld","-uroot","--bind-address=0.0.0.0"]
