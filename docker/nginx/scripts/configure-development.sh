#!/bin/bash
mkdir -p /etc/nginx/ssl

# Create Self-signed SSL Cert for DASHBOARD_DOMAIN
if [ "$GENERATE_SELF_SIGNED_SSL" -eq 1 ] && [ ! -z "$DASHBOARD_DOMAIN" ]
then
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout /etc/nginx/ssl/$DASHBOARD_DOMAIN.key -out /etc/nginx/ssl/$DASHBOARD_DOMAIN.cert -extensions san -config \
  <(echo "[req]";
    echo distinguished_name=req;
    echo "[san]";
    echo subjectAltName=DNS:$DASHBOARD_DOMAIN,IP:10.0.0.1
    ) \
  -subj /CN=$DASHBOARD_DOMAIN

# Update Nginx Config
SSL_CONFIG="server_name DASHBOARD_DOMAIN;\nssl_certificate \/etc\/nginx\/ssl\/DASHBOARD_DOMAIN.cert;\nssl_certificate_key \/etc\/nginx\/ssl\/DASHBOARD_DOMAIN.key;\nssl_trusted_certificate \/etc\/nginx\/ssl\/DASHBOARD_DOMAIN.cert;"
sed -i "s/server_name DASHBOARD_DOMAIN;/$SSL_CONFIG/g" /etc/nginx/conf.d/default.conf
sed -i "s/80/443 ssl http2/g" /etc/nginx/conf.d/default.conf
echo -e "# HTTP redirect\nserver {\nlisten 80;\nlisten [::]:80;\nserver_name DASHBOARD_DOMAIN;\n# letsencrypt support\ninclude /etc/nginx/letsencrypt.conf;\nreturn 301 https://\$host\$request_uri;\n}" >> /etc/nginx/conf.d/default.conf
fi

# Create Self-signed SSL Cert for EFORM_DOMAIN
if [ "$GENERATE_SELF_SIGNED_SSL" -eq 1 ] && [ ! -z "$EFORM_DOMAIN" ]
then
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout /etc/nginx/ssl/$EFORM_DOMAIN.key -out /etc/nginx/ssl/$EFORM_DOMAIN.cert -extensions san -config \
  <(echo "[req]";
    echo distinguished_name=req;
    echo "[san]";
    echo subjectAltName=DNS:$EFORM_DOMAIN,IP:10.0.0.1
    ) \
  -subj /CN=$EFORM_DOMAIN

# Update Nginx Config
SSL_CONFIG="server_name EFORM_DOMAIN;\nssl_certificate \/etc\/nginx\/ssl\/EFORM_DOMAIN.cert;\nssl_certificate_key \/etc\/nginx\/ssl\/EFORM_DOMAIN.key;\nssl_trusted_certificate \/etc\/nginx\/ssl\/EFORM_DOMAIN.cert;"
sed -i "s/server_name EFORM_DOMAIN;/$SSL_CONFIG/g" /etc/nginx/conf.d/default.conf
sed -i "s/80/443 ssl http2/g" /etc/nginx/conf.d/default.conf
echo -e "# HTTP redirect\nserver {\nlisten 80;\nlisten [::]:80;\nserver_name EFORM_DOMAIN;\n# letsencrypt support\ninclude /etc/nginx/letsencrypt.conf;\nreturn 301 https://\$host\$request_uri;\n}" >> /etc/nginx/conf.d/default.conf
fi

# Create Self-signed SSL Cert for RITSUANLARAVEL_DOMAIN
if [ "$GENERATE_SELF_SIGNED_SSL" -eq 1 ] && [ ! -z "$RITSUANLARAVEL_DOMAIN" ]
then
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout /etc/nginx/ssl/$RITSUANLARAVEL_DOMAIN.key -out /etc/nginx/ssl/$RITSUANLARAVEL_DOMAIN.cert -extensions san -config \
  <(echo "[req]";
    echo distinguished_name=req;
    echo "[san]";
    echo subjectAltName=DNS:$RITSUANLARAVEL_DOMAIN,IP:10.0.0.1
    ) \
  -subj /CN=$RITSUANLARAVEL_DOMAIN

# Update Nginx Config
SSL_CONFIG="server_name RITSUANLARAVEL_DOMAIN;\nssl_certificate \/etc\/nginx\/ssl\/RITSUANLARAVEL_DOMAIN.cert;\nssl_certificate_key \/etc\/nginx\/ssl\/RITSUANLARAVEL_DOMAIN.key;\nssl_trusted_certificate \/etc\/nginx\/ssl\/RITSUANLARAVEL_DOMAIN.cert;"
sed -i "s/server_name RITSUANLARAVEL_DOMAIN;/$SSL_CONFIG/g" /etc/nginx/conf.d/default.conf
sed -i "s/80/443 ssl http2/g" /etc/nginx/conf.d/default.conf
echo -e "# HTTP redirect\nserver {\nlisten 80;\nlisten [::]:80;\nserver_name RITSUANLARAVEL_DOMAIN;\n# letsencrypt support\ninclude /etc/nginx/letsencrypt.conf;\nreturn 301 https://\$host\$request_uri;\n}" >> /etc/nginx/conf.d/default.conf
fi

# Update App Domain
sed -i "s/DASHBOARD_DOMAIN/$DASHBOARD_DOMAIN/g" /etc/nginx/conf.d/default.conf
sed -i "s/EFORM_DOMAIN/$EFORM_DOMAIN/g" /etc/nginx/conf.d/default.conf
sed -i "s/RITSUAN_DOMAIN/$RITSUAN_DOMAIN/g" /etc/nginx/conf.d/default.conf
sed -i "s/RITSUANLARAVEL_DOMAIN/$RITSUANLARAVEL_DOMAIN/g" /etc/nginx/conf.d/default.conf
