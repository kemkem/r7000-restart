#!/bin/bash

#admin:password base64 encoded like dXNlcjpwYXNzd29yZA==
AUTH="BASE64-admin:password"

#your router address or IP
R7000_IP="ROUTER IP"

#path to log file
LOG=/path/to/r7000_restart.log

#write some header logs with date
echo "---------------------" >> $LOG
date >> $LOG
echo "---------------------" >> $LOG

#1st step / get csrf 

echo "retrieve CSRF" >> $LOG

XSRF=`curl --location "$R7000_IP" --header "Authorization: Basic $AUTH" --head | grep XSRF_TOKEN | perl -ne '$_ =~ /XSRF_TOKEN=(\d+);/;print $1;'`

#2nd / connect

echo "connect request" >> $LOG

RES=`curl --location "$R7000_IP" --header "Authorization: Basic $AUTH" --header "Set-Cookie: XSRF_TOKEN=$XSRF"`

echo $RES >> $LOG

#3rd / get netgear UI id

echo "retrieve gui id" >> $LOG

ID=`curl --header 'Authorization: Basic $AUTH' $R7000_IP/ADVANCED_home2.htm | grep newgui | perl -ne '$_ =~ /id=(.+)\"\s/;print $1;'`

echo "id $ID" >> $LOG

#4th / call restart

echo "restart request" >> $LOG

curl -X POST $R7000_IP/newgui_adv_home.cgi?id=$ID --header 'Authorization: Basic $AUTH' -H 'Content-Type: application/x-www-form-urlencoded' -d 'buttonSelect=2' >> $LOG


