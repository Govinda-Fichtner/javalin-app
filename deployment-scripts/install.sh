#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_app_instances>"
    exit 1
fi

# Retrieve the first argument
number_of_app_instances=$1

# Check if the argument is a valid number
if ! [[ $number_of_app_instances =~ ^[1-10]+$ ]]; then
    echo "Error: '$number_of_app_instances' is not a valid number."
    exit 1
fi

# create group and user to run the app with
groupadd javalin-app-group
adduser --ingroup javalin-app-group javalin-app-user

# create a systemd file to be able to manage the app
# and configure environment variables for it

# Iterate from 1 to the provided number
for (( i=1; i<=$number_of_app_instances; i++ )); do
    echo "Setup up app instance $i"
    
    cp ./systemd/javalin-app.service /etc/systemd/system/javalin-app-$i.service
    sed -i "s/Description=Javalin-App/Description=Javalin-App-$i/" /etc/systemd/system/javalin-app-$i.service
    sed -i "s/replace_port_value/700$((i-1))/" /etc/systemd/system/javalin-app-$i.service
    
    
    systemctl enable javalin-app-$i
    systemctl start javalin-app-$i
done