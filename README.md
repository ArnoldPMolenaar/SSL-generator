# SSL-generator
SH script to generate local SSL's

## Make generate.sh exectuable
```
chmod +x generate.sh
```

1. Setup domains.txt equal with your nginx or apache domains
2. Execute ./generate.sh

## Create a sym link with current
```
ln /home/user/.ssl/timespan current
ln -s /home/user/.ssl/timespan current
```

## NGINX SSL setting example
```
################
# SSL Settings #
################
ssl_certificate /home/user/.ssl/current/localhost.crt;
ssl_certificate_key /home/user/.ssl/current/localhost.key;
ssl_protocols TLSv1.2 TLSv1.3;
#ssl_ciphers ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384::ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384;
#ssl_ecdh_curve X25519:prime256v1:secp384r1;
ssl_prefer_server_ciphers off;
```

### Example for full nginx config development setup
```
user www-data;
worker_processes auto;
#pid /run/nginx.pid;
include /home/linuxbrew/.linuxbrew/etc/nginx/modules-enabled/*.conf;

events {
    use epoll;
    worker_connections 2048;
}

http {

        ##################
        # Basic Settings #
        ##################

        sendfile on;

        tcp_nopush on;
        tcp_nodelay on;

        keepalive_timeout 30;
        send_timeout 30s;
        keepalive_requests 30;

        client_max_body_size 5m;

        server_tokens off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        proxy_hide_header X-Powered-By;

        ################
        # SSL Settings #
        ################
        ssl_certificate /home/user/.ssl/current/localhost.crt;
        ssl_certificate_key /home/user/.ssl/current/localhost.key;
        ssl_protocols TLSv1.2 TLSv1.3;
        #ssl_ciphers ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384::ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384;
        #ssl_ecdh_curve X25519:prime256v1:secp384r1;
        ssl_prefer_server_ciphers off;

        ####################
        # Logging Settings #
        ####################

        #access_log /var/log/nginx/access.log;
        #error_log /var/log/nginx/error.log;

        #################
        # Gzip Settings #
        #################

        gzip on;
        gzip_static on;
        gzip_http_version 1.1;
        gzip_comp_level 5;
        gzip_min_length 256;
        gzip_types
            application/javascript
            application/json
            application/xhtml+xml
            application/xml
            image/svg+xml
            text/css;

        ########################
        # Virtual Host Configs #
        ########################

        include /home/linuxbrew/.linuxbrew/etc/nginx/conf.d/*.conf;
        include /home/linuxbrew/.linuxbrew/etc/nginx/sites-enabled/*;
}
```
