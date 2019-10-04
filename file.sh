#!/bin/bash
apt update
apt install apache2 -y
echo "HELLO EVERYONE">/var/www/html/index.html
