#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx git
git clone https://github.com/saikiranpi/SecOps-game.git /tmp/SecOps-game
sudo rm -f /var/www/html/index.nginx-debian.html
sudo cp /tmp/SecOps-game/index.html /var/www/html/index.html
echo "<h1>${var.vpc_name}-public-server-${count.index + 1}</h1>" >> /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
testing
testing
testing
  