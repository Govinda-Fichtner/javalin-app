#!/bin/bash
# create group and user to run the app with
groupadd javalin-app-group
adduser --ingroup javalin-app-group javalin-app-user

# create a systemd file to be able to manage the app
# and configure environment variables for it
cp ./systemd/javalin-app.service /etc/systemd/system/
systemctl enable javalin-app
systemctl start javalin-app