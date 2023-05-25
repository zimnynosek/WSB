#!/bin/bash

sudo apt-get install unzip
sudo apt-get install ufw 


if ! systemctl is-active --quiet nginx 
    then
        cd ~
        curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
        sudo bash nodesource_setup.sh
        sudo apt update 
        sudo apt install -y nginx nodejs build-essential unzip
        sudo npm install pm2@latest -g

        sudo ufw allow 'Nginx HTTP'

        sudo systemctl stop nginx
        sudo cat <<EOF > ratingapp
server {
    listen 80;
    listen [::]:80;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        #proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        #proxy_set_header Host $host;
        #proxy_cache_bypass $http_upgrade;
    }
}
EOF
        sudo cp ratingapp /etc/nginx/sites-available/ratingapp
        sudo ln -s /etc/nginx/sites-available/ratingapp /etc/nginx/sites-enabled/
        sudo rm -f /etc/nginx/sites-enabled/default
        sudo systemctl start nginx

    else
        echo "Nginx and other stuff already installed.."
fi


 
  #      pm2 stop rating-api
        
        if test -d /var/www/api/ 
            then
                sudo rm -fR /var/www/api/
                mkdir /var/www/api/
            else
                echo $USER
        fi

        wget https://dev.azure.com/kowalewskiwaldemar/Projekt_WSB/_apis/git/repositories/Projekt_WSB/items?scopePath=media/scripts/api.zip
        unzip api.zip -d /var/www/ 
        chmod 755 -R /var/www/api/
        cd /var/www/api/
        sudo npm install
        
        sudo PORT='3000' MONGODB_URI="mongodb://10.51.4.4:27017/webratings" pm2 start /var/www/api/bin/www --name rating-api
        sudo pm2 startup
        sudo pm2 save

     #   sudo shutdown -h 1


