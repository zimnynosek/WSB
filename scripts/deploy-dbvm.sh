#!/bin/bash

sudo apt-get install unzip

sudo systemctl stop mongod 
sudo sed -i "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf
sudo systemctl start mongod

wget https://raw.githubusercontent.com/zimnynosek/WSB/main/scripts/db.zip



unzip db.zip -d .
chmod +x ./db/import.sh
./db/import.sh
