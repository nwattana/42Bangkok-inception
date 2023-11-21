FROM debian:bookworm
# https://www.debian.org/releases/

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/cert
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=TH/ST=Bangkok/L=Bangkok/O=42Bangkok/OU=nwattana/CN=nwattana.42.fr" \
    -keyout /etc/nginx/cert/inception.key -out /etc/nginx/cert/inception.crt

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN apt update && apt install -y net-tools fish

CMD ["nginx", "-g", "daemon off;"]