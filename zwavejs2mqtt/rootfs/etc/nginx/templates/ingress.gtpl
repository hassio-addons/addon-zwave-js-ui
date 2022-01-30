server {
    listen 8099 default_server;

    include /etc/nginx/includes/server_params.conf;
    include /etc/nginx/includes/proxy_params.conf;
    proxy_set_header X-External-Path {{ .entry }};

    location / {
        allow   172.30.32.2;
        deny    all;

        proxy_pass http://backend;
    }
}