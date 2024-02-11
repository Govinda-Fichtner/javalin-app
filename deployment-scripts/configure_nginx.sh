#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_app_instances>"
    exit 1
fi

# Retrieve the first argument
number_of_app_instances=$1

# Check if the argument is a valid number
if ! [[ $number_of_app_instances =~ ^[0-9]+$ ]]; then
    echo "Error: '$number_of_app_instances' is not a valid number."
    exit 1
fi

# backup orignal nginx config
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup

# create a directory to store the backend server configurations
mkdir /etc/nginx/backend_servers

# copy nginx config to target
cp ./nginx.conf /etc/nginx/

# Iterate from 1 to the provided number of app instances
for (( i=1; i<=$number_of_app_instances; i++ )); do
    echo "Setup up app instance $i"
    echo "server 127.0.0.1:700$((i-1));" > /etc/nginx/backend_servers/javalin-app-$((i-1)).conf
done

systemctl reload nginx