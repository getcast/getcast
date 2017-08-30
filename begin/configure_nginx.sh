#!/bin/bash

# install nginx
sudo apt-get update
sudo apt-get install nginx

# set configuration file for getcast
sh nginx/nginx_settings.sh getcast.nargothrond.me /home/getcast/public