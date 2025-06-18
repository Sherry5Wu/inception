#!/bin/sh

set -e

echo "Creating a test user and setting the home directory..."
if ! id "$FTP_USER" >/dev/null 2>&1; then
  adduser -D -h "/home/$FTP_USER" "$FTP_USER"
  echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
  addgroup "$FTP_USER" www-data
fi

echo "Starting pure-ftpd..."
pure-ftpd -j -p 30000:30042 -E -H -l unix


# adduser -D -h "/home/$FTP_USER" "$FTP_USER"
# echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# # add FTP user to the www-data group to obtain write permission
# # in WordPress volume
# addgroup "$FTP_USER" www-data

# echo "Starting pure-ftpd..."

# # -j: jail users to their home directories, prevent users from navigating
# # outside their folders
# # -p 30000:30042: specify passive mode port range
# # -E → no anonymous users
# # -H → hide dotfiles (optional)
# # -l unix → explicit local user auth

# # pure-ftpd -j -p 30000:30042
# pure-ftpd -j -p 30000:30042 -E -H -l unix
