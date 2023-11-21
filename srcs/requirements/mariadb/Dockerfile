FROM debian:bookworm

RUN apt update && apt install -y fish
RUN apt update && apt install -y mariadb-server  mariadb-client

RUN mkdir /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

RUN apt update && apt install -y net-tools fish

COPY ./scripts/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

# CMD ["tail", "-f", "/dev/null"]
CMD ["mysqld","-uroot","--bind-address=0.0.0.0"]

# TODO dump old db to here