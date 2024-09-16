#!/bin/bash
mkdir -p /etc/nginx/ssl
sed -i "s/DASHBOARD_DOMAIN/$DASHBOARD_DOMAIN/g" /etc/nginx/conf.d/default.conf
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

# Create Self-signed SSL Cert for APP Domain
if [ ! -z "$DASHBOARD_DOMAIN" ]
then
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout /etc/nginx/ssl/$DASHBOARD_DOMAIN.key -out /etc/nginx/ssl/$DASHBOARD_DOMAIN.cert -extensions san -config \
  <(echo "[req]";
    echo distinguished_name=req;
    echo "[san]";
    echo subjectAltName=DNS:$DASHBOARD_DOMAIN,IP:10.0.0.1
    ) \
  -subj /CN=$DASHBOARD_DOMAIN
fi
