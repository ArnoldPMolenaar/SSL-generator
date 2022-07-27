#!/bin/bash

# Create a variable so we can create a folder with it
TIME_TAG=$(date +%Y%m%d%H%M%S)

# Make the folder and go into it
mkdir $TIME_TAG
cd $TIME_TAG

# Generate root certificate
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout RootCA.key -out RootCA.pem -subj "/C=NL/CN=Development-Root-CA"
openssl x509 -outform pem -in RootCA.pem -out RootCA.crt

# Generate cerificates
openssl req -new -nodes -newkey rsa:2048 -keyout localhost.key -out localhost.csr -subj "/C=NL/ST=<Province>/L=<City>/O=Development-Certificates/CN=localhost.local"
openssl x509 -req -sha256 -days 1024 -in localhost.csr -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile ../domains.ext -out localhost.crt
