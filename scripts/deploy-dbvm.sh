#!/bin/bash

sudo apt-get install unzip

sudo systemctl stop mongod 
sudo sed -i "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf
sudo systemctl start mongod

wget https://dev.azure.com/kowalewskiwaldemar/Projekt_WSB/_apis/git/repositories/Projekt_WSB/items?scopePath=media/scripts/db.zip



unzip db.zip -d .
chmod +x ./db/import.sh
./db/import.sh
