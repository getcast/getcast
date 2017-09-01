#!/bin/bash

# parameters
SETTINGS_FILE=$1
STATIC_ROOT=$2

# create nginx settings if not exists
if [ ! -f /etc/nginx/sites_available/$1 ]; then
cat >"/etc/nginx/sites-available/$1" <<EOL
upstream backend {
	server localhost:3000;
}

server {
	listen 80;
	server_name $1;

	root $2;

	location / {
		try_files \$uri @backend;
	}

	location @backend {	
		proxy_pass http://backend;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header Host \$host;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		# Following is necessary for Websocket support
		proxy_http_version 1.1;
		proxy_set_header Upgrade \$http_upgrade;
		proxy_set_header Connection "upgrade";
	}
}
EOL
fi
