#!/bin/sh

set -e

echo "Creating a test user and setting the home directory..."
adduser -D -h "/home/$FTP_USER" "$FTP_USER"
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# add FTP user to the www-data group to obtain write permission
# in WordPress volume
addgroup "$FTP_USER" www-data

echo "Starting pure-ftpd..."

# -j: jail users to their home directories, prevent users from navigating
# outside their folders
# -p 30000:30042: specify passive mode port range
pure-ftpd -j -p 30000:30042
