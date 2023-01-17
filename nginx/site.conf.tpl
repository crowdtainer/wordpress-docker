server {
    listen 80;
    listen [::]:80;

    server_name ${domain} www.${domain};

    location /.well-known/acme-challenge/ {
	allow all;
        root /var/www/certbot/${domain};
    }

    location / {
       rewrite ^ https://$host$request_uri? permanent;
    }
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    server_name ${domain} www.${domain};

    index index.php index.html index.htm;
    
#    root /var/www/html/${domain};
    root /var/www/html;

    server_tokens off;

    ssl_certificate /etc/nginx/sites/ssl/dummy/${domain}/fullchain.pem;
    ssl_certificate_key /etc/nginx/sites/ssl/dummy/${domain}/privkey.pem;

    include /etc/nginx/includes/options-ssl-nginx.conf;

    ssl_dhparam /etc/nginx/sites/ssl/ssl-dhparams.pem; #TODO: leave? 
    include /etc/nginx/includes/hsts.conf; # TODO: leave?

    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src * data: 'unsafe-eval' 'unsafe-inline'" always;
    # add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
    # enable strict transport security only if you understand the implications

    location / {
            try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
            try_files $uri =404;
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass wordpress:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param PATH_INFO $fastcgi_path_info;
    }

    location ~ /\.ht {
            deny all;
    }
    
    location = /favicon.ico { 
            log_not_found off; access_log off; 
    }
    location = /robots.txt { 
            log_not_found off; access_log off; allow all; 
    }
    location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
            expires max;
            log_not_found off;
    }
    
}
